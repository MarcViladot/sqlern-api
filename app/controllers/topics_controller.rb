class TopicsController < ApplicationController

  before_action :authenticate_admin

  api :GET, "/topics", "Get all topics"
  def index
    topics = Topic.all
    render json: topics
  end

  api :POST, "/topics", "Create topic"
  param :name, String, desc: 'name of the topic', :required => true
  header 'Authorization', 'Auth header', :required => true
  def create
    topic = Topic.new(topic_params)
    if topic.save
      render json: topic
    else
      render json: topic.errors
    end
  end

  api :DELETE, "/topics/:id", "Delete topic by id"
  param :id, :number, desc: 'id of the topic', :required => true
  header 'Authorization', 'Auth header', :required => true
  def destroy
    topic = Topic.find(params[:id])
    topic.destroy
    render json: topic
  end

  api :GET, "/topics/:id", "Show topic by id"
  param :id, :number, desc: 'id of the topic', :required => true
  header 'Authorization', 'Auth header', :required => true
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
