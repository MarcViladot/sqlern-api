class ExersicesController < ApplicationController

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
    exercise = Exercise.find(params[:id])
    render json: exercise
  end

  def update
    exercise = Exercise.find(params[:id])
    if x.update_attributes(x_params)
      render json: exercise
    else
      render json: exercise.errors
    end
  end

  private

  def exersice_params
    params.permit()
  end

end
