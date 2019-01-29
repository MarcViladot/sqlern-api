class GeneratedquizzsController < ApplicationController

  #before_action :authenticate_request, only: [:show]

  def index
    generatedquizzs = Generatedquizz.all
    render json: generatedquizzs
  end

  def create
    generatedquizz = Generatedquizz.new(generatedquizz_params)
    if generatedquizz.save
      render json: generatedquizz
    else
      render json: generatedquizz.errors
    end
  end

  def destroy
    generatedquizz = Generatedquizz.find(params[:id])
    generatedquizz.destroy
    render json: generatedquizz
  end

  def show
    @generatedquizz = Generatedquizz.find(params[:id])
  end

  def show_by_code
    @generatedquizz = Generatedquizz.find_by_code(params[:code])
  end

  def update
    generatedquizz = Generatedquizz.find(params[:id])
    if generatedquizz.update_attributes(generatedquizz_params)
      render json: generatedquizz
    else
      render json: generatedquizz.errors
    end
  end

  private

  def generatedquizz_params
    params.permit(:user_id, :quizz_id)
  end

end
