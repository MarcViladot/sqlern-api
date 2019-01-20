class TopicexercisesController < ApplicationController

  def index
    topicexercises = Topicexercise.all
    render json: topicexercises
  end

  def create
    topicexercise = Topicexercise.new(topicexercise_params)
    if topicexercise.save
      render json: topicexercise
    else
      render json: topicexercise.errors
    end
  end

  def destroy
    topicexercise = Topicexercise.find(params[:id])
    topicexercise.destroy
    render json: topicexercise
  end

  def show
    topicexercise = Topicexercise.find(params[:id])
    render json: topicexercise
  end

  def update
    topicexercise = Topicexercise.find(params[:id])
    if topicexercise.update_attributes(topicexercise_params)
      render json: topicexercise
    else
      render json: topicexercise.errors
    end
  end

  private

  def topicexercise_params
    params.permit()
  end

end
