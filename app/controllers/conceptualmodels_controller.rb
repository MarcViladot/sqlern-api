class ConceptualmodelsController < ApplicationController

  before_action :authenticate_teacher
  before_action :authenticate_admin, only: [:index]

  api :GET, "/conceptualmodels", "Get all conceptual models"
  def index
    conceptualmodels = Conceptualmodel.all
    render json: conceptualmodels
  end

  api :POST, "/conceptualmodels", "Create Conceptual model"
  param :name, String, desc: 'name of the model', :required => true
  param :url, String, desc: 'url of the image', :required => true
  header 'Authorization', 'Auth header', :required => true
  def create
    conceptualmodel = Conceptualmodel.new(conceptualmodel_params)
    if conceptualmodel.save
      render json: conceptualmodel
    else
      render json: conceptualmodel.errors
    end
  end

  api :DELETE, "/conceptualmodels/:id", "Delete Conceptual model by id"
  param :id, :number, desc: 'id of the model', :required => true
  header 'Authorization', 'Auth header', :required => true
  def destroy
    conceptualmodel = Conceptualmodel.find(params[:id])
    conceptualmodel.destroy
    render json: conceptualmodel
  end

  api :GET, "/conceptualmodels/:id", "Show Conceptual model by id"
  param :id, :number, desc: 'id of the model', :required => true
  header 'Authorization', 'Auth header', :required => true
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
    params.permit(:url, :name).merge(user_id: @current_user.id)
  end

end
