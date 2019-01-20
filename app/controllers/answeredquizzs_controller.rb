class AnsweredquizzsController < ApplicationController

  def index
    answeredquizzs = Answeredquizz.all
    render json: answeredquizzs
  end

  def create
    answeredquizz = Answeredquizz.new(answeredquizz_params)
    if answeredquizz.save
      render json: answeredquizz
    else
      render json: answeredquizz.errors
    end
  end

  def destroy
    answeredquizz = Answeredquizz.find(params[:id])
    answeredquizz.destroy
    render json: answeredquizz
  end

  def show
    answeredquizz = Answeredquizz.find(params[:id])
    render json: answeredquizz
  end

  def update
    answeredquizz = Answeredquizz.find(params[:id])
    if answeredquizz.update_attributes(answeredquizz_params)
      render json: answeredquizz
    else
      render json: answeredquizz.errors
    end
  end

  private

  def answeredquizz_params
    params.permit()
  end

end
