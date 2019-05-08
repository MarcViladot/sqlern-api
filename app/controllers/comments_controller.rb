class CommentsController < ApplicationController

  before_action :authenticate_teacher
  before_action :authenticate_admin, only: [:index]

  api :GET, "/comments", "Get all comments"
  def index
    comments = Comment.all
    render json: comments
  end

  api :POST, "/comments", "Create comment"
  param :exercise_id, :number, desc: 'id of the exercise', :required => true
  param :comment, String, desc: 'comment or hint', :required => true
  header 'Authorization', 'Auth header', :required => true
  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: comment
    else
      render json: comment.errors
    end
  end

  api :DELETE, "/comments/:id", "Delete comment by id"
  param :id, :number, desc: 'id of the comment', :required => true
  header 'Authorization', 'Auth header', :required => true
  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    render json: comment
  end

  api :GET, "/comments/:id", "Show comment by id"
  param :id, :number, desc: 'id of the comment', :required => true
  header 'Authorization', 'Auth header', :required => true
  def show
    comment = Comment.find(params[:id])
    render json: comment
  end

  def update
    comment = Comment.find(params[:id])
    if comment.update_attributes(comment_params)
      render json: comment
    else
      render json: comment.errors
    end
  end

  private

  def comment_params
    params.permit(:comment, :exercise_id).merge(user_id: @current_user.id)
  end

end
