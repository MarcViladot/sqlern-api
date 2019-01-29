class AnsweredexercisesController < ApplicationController

  def index
    answeredexercise = Answeredexercise.all
    render json: answeredexercises
  end

  def create
    connection = ActiveRecord::Base.establish_connection(:development)
    solution = Exercise.find(params[:exercise_id]).solution
    ActiveRecord::Base.remove_connection(connection)

    base = ActiveRecord::Base.establish_connection(:development_aux)
    begin
      student_solution = base.connection.execute(params[:student_solution]).to_json
      correct = base.connection.execute(solution).to_json == student_solution
      ActiveRecord::Base.remove_connection(base)
    rescue
      correct = false
    end
    ActiveRecord::Base.establish_connection(:development)
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
