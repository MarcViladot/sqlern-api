class ConceptualmodelsController < ApplicationController
  def index
    conceptualmodels = Conceptualmodel.all
    render json: conceptualmodels
  end

  def create
    conceptualmodel = Conceptualmodel.new(conceptualmodel_params)
    if conceptualmodel.save
      render json: conceptualmodel
    else
      render json: conceptualmodel.errors
    end
  end

  def destroy
    conceptualmodel = Conceptualmodel.find(params[:id])
    conceptualmodel.destroy
    render json: conceptualmodel
  end

  def show
    conceptualmodel = Conceptualmodel.find(params[:id])
    render json: conceptualmodel
  end

  def update
    conceptualmodel = Conceptualmodel.find(params[:id])
    if conceptualmodel.update_attributes(conceptualmodel_params)
      render json: conceptualmodel
    else
      render json: conceptualmodel.errors
    end
  end

  private

  def conceptualmodel_params
    params.permit()
  end

end
