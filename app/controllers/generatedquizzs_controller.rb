class GeneratedquizzsController < ApplicationController

  before_action :authenticate_admin, only: [:index]
  # before_action :authenticate_student, only: [:show_by_code]
  # before_action :authenticate_teacher

  api :GET, "/generatedquizzs", "Get all Generated Quizzs"
  header 'Authorization', 'Auth header', :required => true
  def index
    generatedquizzs = Generatedquizz.all
    render json: generatedquizzs
  end

  api :POST, "/generatedquizzs", "create Generated Quizz by id"
  param :quizz_id, :number, desc: 'id of the quizz', :required => true
  header 'Authorization', 'Auth header', :required => true
  def create
    generatedquizz = Generatedquizz.new(generatedquizz_params)
    if generatedquizz.save
      render json: generatedquizz
    else
      render json: generatedquizz.errors
    end
  end

  api :DELETE, "/generatedquizzs/:id", "Delete generated quizz by id"
  param :id, :number, desc: 'id of the generated quizz', :required => true
  header 'Authorization', 'Auth header', :required => true
  def destroy
    generatedquizz = Generatedquizz.find(params[:id])
    generatedquizz.destroy
    render json: generatedquizz
  end

  api :GET, "/generatedquizzs/:id", "Find Generated Quizz by id"
  param :id, :number, desc: 'id of the generated quizz', :required => true
  header 'Authorization', 'Auth header', :required => true
  def show
    @generatedquizz = Generatedquizz.find(params[:id])
  end

  api :GET, "/generatedquizzs/:code", "Find Generated Quizz by code"
  param :code, String, desc: 'code of the generated quizz', :required => true
  header 'Authorization', 'Auth header', :required => true
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
    params.permit(:quizz_id).merge(user_id: @current_user.id)
  end

end
