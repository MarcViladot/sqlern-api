class AnsweredexercisesController < ApplicationController

  def index
    answeredexercise = Answeredexercise.all
    render json: answeredexercises
  end

  api :POST, "/answeredexercises", "Correct exercise"
  param :exercise_id, :number, desc: 'id of the exercise', :required => true
  param :student_solution, String, desc: 'solution provided by the student', :required => true
  header 'Authorization', 'Auth header', :required => true
  def create
    correct = correct_exercise(params[:exercise_id], params[:student_solution])
    answeredexercise = Answeredexercise.new('answered' => params[:student_solution],
                                            'correct' => correct,
                                            'exercise_id' => params[:exercise_id],
                                            'user_id' => @current_user.id
                                            )
    if answeredexercise.save
      render json: answeredexercise
    else
      render json: answeredexercise.errors
    end
  end

  def destroy
    answeredexercise = Answeredexercise.find(params[:id])
    answeredexercise.destroy
    render json: answeredexercise
  end

  def show
    answeredexercise = Answeredexercise.find(params[:id])
    render json: answeredexercise
  end

  def update
    answeredexercise = Answeredexercise.find(params[:id])
    if answeredexercise.update_attributes(answeredexercise_params)
      render json: answeredexercise
    else
      render json: answeredexercise.errors
    end
  end

  private

  def answeredexercise_params
    params.permit()
  end

end
