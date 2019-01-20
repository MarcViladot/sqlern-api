class JoinansweredsController < ApplicationController

  def index
    joinanswereds = Joinanswered.all
    render json: joinanswereds
  end

  def create
    joinanswered = Joinanswered.new(joinanswered_params)
    if joinanswered.save
      render json: joinanswered
    else
      render json: joinanswered.errors
    end
  end

  def destroy
    joinanswered = Joinanswered.find(params[:id])
    joinanswered.destroy
    render json: joinanswered
  end

  def show
    joinanswered = Joinanswered.find(params[:id])
    render json: joinanswered
  end

  def update
    joinanswered = Joinanswered.find(params[:id])
    if joinanswered.update_attributes(joinanswered_params)
      render json: joinanswered
    else
      render json: joinanswered.errors
    end
  end

  private

  def joinanswered_params
    params.permit()
  end

end
