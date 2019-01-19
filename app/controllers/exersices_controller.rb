class ExersicesController < ApplicationController

  def index
    x = X.all
    render json: x
  end

  def create
    x = Exercise.new(exersice_params)
    if x.save
      render json: x
    else
      render json: x.errors
    end
  end

  def destroy
    x = X.find(params[:id])
    x.destroy
    render json: x
  end

  def show
    x = X.find(params[:id])
    render json: x
  end

  def update
    x = X.find(params[:id])
    if x.update_attributes(x_params)
      render json: x
    else
      render json: x.errors
    end
  end

  private

  def exersice_params
    params.permit()
  end

end
