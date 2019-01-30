class ExercisesController < ApplicationController

  def index
    exercises = Exercise.all
    render json: exercises
  end

  def create
    exercise = Exercise.new(exersice_params)
    if exercise.save
      render json: exercise
    else
      render json: exercise.errors
    end
  end

  def destroy
    exercise = Exercise.find(params[:id])
    exercise.destroy
    render json: exercise
  end

  def show
    @exercise = Exercise.find(params[:id])
  end

  def index_set
    topics = params[:topics].split("+")
    @exercises = Exercise.joins(:topics).where("topics.name IN (?)", topics).sort_by { rand }.take(params[:limit].to_i)
  end

  def index_set_intelligent
    topics_hash = Hash.new
    failed_exercises = Exercise.joins(:answeredexercises).where("answeredexercises.user_id = ? AND correct = false", @current_user.id)
    failed_exercises.each do |exercise|
      exercise.topics.each do |topic|
        if !topics_hash.key?(topic.name)
          topics_hash[topic.name] = 1
        else
          topics_hash[topic.name] += 1
        end
      end
    end
    topics = topics_hash.keys.take(3)
    @exercises = Exercise.joins(:topics).where("topics.name IN (?)", topics).sort_by { rand }.take(25)
  end

  def update
    exercise = Exercise.find(params[:id])
    if exercise.update_attributes(x_params)
      render json: exercise
    else
      render json: exercise.errors
    end
  end

  private

  def exersice_params
    params.permit(:statement, :solution, :public, :conceptualmodel_id).merge(user_id: @current_user.id)
  end

end
