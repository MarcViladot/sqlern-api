class ExercisesController < ApplicationController

  before_action :authenticate_admin, only: [:index]
  before_action :authenticate_teacher, only: [:create, :destroy, :show, :update]
  before_action :authenticate_student, only: [:index_set_intelligent]


  api :GET, "/exercises", "Get all exercises"
  def index
    exercises = Exercise.all
    render json: exercises
  end

  api :POST, "/exercises", "Create exercise"
  param :statement, String, desc: 'statement of the exercise', :required => true
  param :solution, String, desc: 'solution of the exercise', :required => true
  param :public, :boolean, desc: 'exercise is public', :required => true
  param :topics, String, desc: 'ids of topics of the exercise', :required => true
  param :conceptualmodel_id, :number, desc: 'id of the conceptual model', :required => true
  header 'Authorization', 'Auth header', :required => true
  def create
    exercise = Exercise.new(exercise_params)
    if exercise.save
      topics = params[:topics].split("+")
      topics.each do |id|
        Topicexercise.new('exercise_id' => exercise.id,
                          'topic_id' => id).save
      end
      render json: exercise
    else
      render json: exercise.errors
    end
  end

  api :DELETE, "/exercises/:id", "Delete exercise by id"
  param :id, :number, desc: 'id of the exercise', :required => true
  header 'Authorization', 'Auth header', :required => true
  def destroy
    exercise = Exercise.find(params[:id])
    exercise.destroy
    render json: exercise
  end

  api :GET, "/exercises/set/publics", "Find public exercises"
  header 'Authorization', 'Auth header', :required => true
  def index_public
    @exercises = Exercise.where("exercises.public = true").uniq.sort_by { rand }
  end

  api :GET, "/exercises/set/publics/:limit", "Find public exercises with limit"
  param :limit, :number, desc: 'number of exercises to find', :required => true
  header 'Authorization', 'Auth header', :required => true
  def index_set_public
    @exercises = Exercise.where("exercises.public = true").uniq.sort_by { rand }.take(params[:limit].to_i)
  end

  api :GET, "/exercises/:id", "Find exercise by id"
  param :id, :number, desc: 'id of the exercise', :required => true
  header 'Authorization', 'Auth header', :required => true
  def show
    @exercise = Exercise.find(params[:id])
  end

  api :GET, "/exercises/set/:limit/:topics", "Find exercises by topics"
  param :limit, :number, desc: 'number of exercises to find', :required => true
  param :topics, String, desc: 'topics of the exercises', :required => true
  header 'Authorization', 'Auth header', :required => true
  def index_set
    topics = params[:topics].split("+")
    if params[:limit] == '0'
      @exercises = Exercise.joins(:topics).where("topics.name IN (?) AND exercises.public = true AND exercises.user_id != ?", topics, @current_user.id).uniq.sort_by { rand }
    else
      @exercises = Exercise.joins(:topics).where("topics.name IN (?) AND exercises.public = true AND exercises.user_id != ?", topics, @current_user.id).uniq.sort_by { rand }.take(params[:limit].to_i)
    end
  end

  api :GET, "/exercises/set/intelligent", "Find exercises intelligent mode"
  header 'Authorization', 'Auth header', :required => true
  def index_set_intelligent
    topics_hash = Hash.new
    failed_exercises = Exercise.joins(:answeredexercises).where("answeredexercises.user_id = ? AND correct = false AND exercises.public = true", @current_user.id)
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
    @exercises = Exercise.joins(:topics).where("topics.name IN (?)", topics).sort_by { rand }.uniq.take(25)
  end

  api :PUT, "/exercises/:id", "Update exercise by id"
  param :id, :number, desc: 'id of the exercise', :required => true
  param :statement, String, desc: 'statement of the exercise'
  param :solution, String, desc: 'solution of the exercise'
  param :public, :boolean, desc: 'exercise is public'
  param :conceptualmodel_id, :number, desc: 'id of the conceptual model'
  header 'Authorization', 'Auth header', :required => true
  def update
    exercise = Exercise.find(params[:id])
    if exercise.update_attributes(exercise_params)
      render json: exercise
    else
      render json: exercise.errors
    end
  end

  private

  def exercise_params
    params.permit(:statement, :solution, :public, :conceptualmodel_id).merge(user_id: @current_user.id)
  end

end
