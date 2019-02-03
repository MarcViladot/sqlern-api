class CommentsController < ApplicationController

  def index
    comments = Comment.all
    render json: comments
  end

  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: comment
    else
      render json: comment.errors
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    render json: comment
  end

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
