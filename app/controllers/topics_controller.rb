class TopicsController < ApplicationController

  def index
    topics = Topic.all
    render json: topics
  end

  def create
    topic = Topic.new(topic_params)
    if topic.save
      render json: topic
    else
      render json: topic.errors
    end
  end

  def destroy
    topic = Topic.find(params[:id])
    topic.destroy
    render json: topic
  end

  def show
    topic = Topic.find(params[:id])
    render json: topic
  end

  def update
    topic = Topic.find(params[:id])
    if topic.update_attributes(topic_params)
      render json: topic
    else
      render json: topic.errors
    end
  end

  private

  def topic_params
    params.permit(:name)
  end

end
