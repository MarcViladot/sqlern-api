class GeneratedquizzsController < ApplicationController

  def index
    generatedquizzs = Generatedquizz.all
    render json: generatedquizzs
  end

  def create
    generatedquizz = Generatedquizz.new(x_params)
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
    generatedquizz = Generatedquizz.find(params[:id])
    render json: generatedquizz
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
    params.permit()
  end

end
