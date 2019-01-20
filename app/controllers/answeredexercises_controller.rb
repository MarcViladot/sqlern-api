class AnsweredexercisesController < ApplicationController

  def index
    answeredexercise = Answeredexercise.all
    render json: answeredexercises
  end

  def create
    answeredexercise = Answeredexercise.new(answeredexercise_params)
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
