class AnsweredquizzsController < ApplicationController

  require 'json'
  before_action :authenticate_student, only: [:create]
  before_action :authenticate_admin, only: [:index]

  api :GET, "/answeredquizzs", "Get all answered quizzs"
  header 'Authorization', 'Auth header', :required => true
  def index
    answeredquizzs = Answeredquizz.all
    render json: answeredquizzs
  end

  api :POST, "/answeredquizzs", "Create answered quizz"
  param :generatedquizz_id, :number, desc: 'id of the generated quizz', :required => true
  param :exercises, String, desc: 'Json stringify of answered exercises', :required => true
  header 'Authorization', 'Auth header', :required => true
  def create
    total = 0
    @answeredquizz = Answeredquizz.new(answeredquizz_params)
    @answeredquizz.save

    exercises = JSON.parse(params[:exercises])
    exercises.each do |exercise|
      correct = correct_exercise(exercise['exercise_id'], exercise['student_solution'])
      answeredexercise = Answeredexercise.new('answered' => exercise['student_solution'],
                                              'correct' => correct,
                                              'exercise_id' => exercise['exercise_id'],
                                              'user_id' => @current_user.id
                                              )
      answeredexercise.save
      if correct
        total = total + 1
      end
      Joinanswered.new('answeredquizz_id' => @answeredquizz.id,
                       'answeredexercise_id' => answeredexercise.id).save
    end
    @answeredquizz.update_column(:note, total)
  end

  api :DELETE, "/answeredquizzs/:id", "Delete Answered quizz"
  param :id, :number, desc: 'id of the generated quizz', :required => true
  header 'Authorization', 'Auth header', :required => true
  def destroy
    answeredquizz = Answeredquizz.find(params[:id])
    answeredquizz.destroy
    render json: answeredquizz
  end

  api :GET, "/answeredquizzs/:id", "Get Answered quizz"
  param :id, :number, desc: 'id of the generated quizz', :required => true
  header 'Authorization', 'Auth header', :required => true
  def show
    @answeredquizz = Answeredquizz.find(params[:id])
  end

  def update
    answeredquizz = Answeredquizz.find(params[:id])
    if answeredquizz.update_attributes(answeredquizz_params)
      render json: answeredquizz
    else
      render json: answeredquizz.errors
    end
  end

  private

  def answeredquizz_params
    params.permit(:generatedquizz_id).merge(user_id: @current_user.id)
  end

end
