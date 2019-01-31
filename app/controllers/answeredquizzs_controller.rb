class AnsweredquizzsController < ApplicationController

  require 'json'

  def index
    answeredquizzs = Answeredquizz.all
    render json: answeredquizzs
  end

  api :POST, "/answeredquizzs", "Create answered quizz"
  param :generatedquizz_id, String, desc: 'id of the generated quizz', :required => true
  param :exercises, String, desc: 'Json stringify of answered exercises', :required => true
  header 'Authorization', 'Auth header', :required => true
  def create
    total = 0
    answeredquizz = Answeredquizz.new(answeredquizz_params).save
    exercices = JSON.parse(params[:exercises])
    exercises.each do |exercise|
      correct = correct_exercise(exercise['exercise_id'], exercise['student_solution'])
      answeredexercise = Answeredexercise.new('answered' => exercise['student_solution'],
                                              'correct' => correct,
                                              'exercise_id' => exercise['exercise_id'],
                                              'user_id' => @current_user.id
                                              ).save
      total +=1 unless !correct
      Joinanswered.new('answeredquizz_id' => answeredquizz.id,
                       'answeredexercise_id' => answeredexercise.id).save
    end
    note = total / exercises.length * 10
    answeredquizz.update_column(:note, note)
  end

  def destroy
    answeredquizz = Answeredquizz.find(params[:id])
    answeredquizz.destroy
    render json: answeredquizz
  end

  def show
    answeredquizz = Answeredquizz.find(params[:id])
    render json: answeredquizz
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
