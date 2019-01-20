class QuizzexercisesController < ApplicationController

  def index
    quizzexercises = Quizzexercise.all
    render json: quizzexercises
  end

  def create
    quizzexercise = Quizzexercise.new(quizzexercise_params)
    if quizzexercise.save
      render json: quizzexercise
    else
      render json: quizzexercise.errors
    end
  end

  def destroy
    quizzexercise = Quizzexercise.find(params[:id])
    quizzexercise.destroy
    render json: quizzexercise
  end

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
    params.permit()
  end

end
