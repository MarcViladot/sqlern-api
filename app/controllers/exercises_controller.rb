class ExercisesController < ApplicationController

  def index
    exercises = Exercise.all
    render json: exercises
  end

  def create
    exercise = Exercise.new(exersice_params)
    if exercise.save
      render json: exercise
    else
      render json: exercise.errors
    end
  end

  def destroy
    exercise = Exercise.find(params[:id])
    exercise.destroy
    render json: exercise
  end

  def show
    @exercise = Exercise.find(params[:id])
  end

  def index_set
    topics = params[:topics].split("+")
    @exercises = Exercise.joins(:topics).where("topics.name IN (?)", topics).sort_by { rand }.take(params[:limit].to_i)
  end

  def update
    exercise = Exercise.find(params[:id])
    if exercise.update_attributes(x_params)
      render json: exercise
    else
      render json: exercise.errors
    end
  end

  private

  def exersice_params
    params.permit(:statement, :solution, :public, :conceptualmodel_id).merge(user_id: @current_user.id)
  end

end
