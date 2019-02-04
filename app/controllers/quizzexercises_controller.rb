class QuizzexercisesController < ApplicationController

  api :GET, "/quizzexercises", "Get all exercices of quizz"
  header 'Authorization', 'Auth header', :required => true
  def index
    quizzexercises = Quizzexercise.all
    render json: quizzexercises
  end

  api :POST, "/quizzexercises", "Create quizz exercise"
  param :exercise_id, String, desc: 'id of the exercise', :required => true
  param :quizz_id, String, desc: 'id of the quizz', :required => true
  header 'Authorization', 'Auth header', :required => true
  def create
    quizzexercise = Quizzexercise.new(quizzexercise_params)
    if quizzexercise.save
      render json: quizzexercise
    else
      render json: quizzexercise.errors
    end
  end

  api :POST, "/quizzexercises/:id", "Delete quizz exercise"
  param :id, String, desc: 'id of the quizz exercise', :required => true
  header 'Authorization', 'Auth header', :required => true
  def destroy
    quizzexercise = Quizzexercise.find(params[:id])
    quizzexercise.destroy
    render json: quizzexercise
  end

  api :GET, "/quizzexercises/:id", "Show quizz exercise"
  param :id, String, desc: 'id of the quizz exercise', :required => true
  header 'Authorization', 'Auth header', :required => true
  def show
    quizzexercise = Quizzexercise.find(params[:id])
    render json: quizzexercise
  end

  def update
    quizzexercise = Quizzexercise.find(params[:id])
    if quizzexercise.update_attributes(quizzexercise_params)
      render json: quizzexercise
    else
      render json: quizzexercise.errors
    end
  end

  private

  def quizzexercise_params
    params.permit(:exercise_id, :quizz_id)
  end

end
