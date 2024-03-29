class QuizzsController < ApplicationController

  require 'json'
  before_action :authenticate_admin, only: [:index]
  before_action :authenticate_teacher

  api :GET, "/quizzs", "Show all the quizzs"
  def index
    quizzs = Quizz.all
    render json: quizzs
  end

  api :POST, "/quizzs", "Create quizz"
  param :name, String, desc: 'name of the quizz', :required => true
  param :topics, String, desc: 'topics of the quizz', :required => true
  param :public, :boolean, desc: 'quizz is public', :required => true
  param :exercises, String, desc: 'Json stringify of exercises', :required => true
  header 'Authorization', 'Auth header', :required => true
  def create
    quizz = Quizz.new(quizz_params)
    if quizz.save
      exercises = JSON.parse(params[:exercises])
      exercises.each do |exercise|
        Quizzexercise.new('exercise_id' => exercise['id'],
                          'quizz_id' => quizz.id).save
      end
      topics = params[:topics].split("+")
      topics.first.each do |t|
        topic = Topic.find_by_name(t)
        Topicquizz.new('quizz_id' => quizz.id,
                       'topic_id' => topic.id).save
      end
      render json: quizz
    else
      render json: quizz.errors
    end
  end

  api :DELETE, "/quizzs/:id", "Delete quizz by id"
  param :id, :number, desc: 'id of the quizz', :required => true
  header 'Authorization', 'Auth header', :required => true
  def destroy
    quizz = Quizz.find(params[:id])
    quizz.destroy
    render json: quizz
  end

  api :POST, "/quizzs/upvote/:quizz_id", "Upvote Quizz"
  param :quizz_id, :number, :required => true
  header 'Authorization', 'Auth header', :required => true
  def upvote
    voted = QuizzVote.create(params.permit(:quizz_id).merge(user_id: @current_user.id))
    if voted.save
      render json: voted
    else
      render json: voted.errors
    end
  end

  api :DELETE, "/quizzs/downvote/:quizz_id", "Unvote Quizz"
  param :quizz_id, :number, :required => true
  header 'Authorization', 'Auth header', :required => true
  def downvote
    voted = QuizzVote.find_by(user_id: @current_user.id, quizz_id: params[:quizz_id])
    voted.destroy
    render json: voted
  end

  api :GET, "/quizzs/set/:topics", "Find quizzs by topics"
  param :topics, String, desc: 'topics of the exercises', :required => true
  param :name, String, desc: 'name of the quizz', :required => true
  header 'Authorization', 'Auth header', :required => true
  def index_set
    topics = params[:topics].split("+")
    puts params[:name]
    @quizzs = Quizz.joins(:topics).where("topics.name IN (?) AND quizzs.public = true AND quizzs.user_id != ? AND quizzs.name LIKE ?", topics, @current_user.id, "%#{params[:name]}%").uniq
  end

  api :GET, "/quizzs/:id", "Find quizz by id"
  param :id, :number, desc: 'id of the quizz', :required => true
  header 'Authorization', 'Auth header', :required => true
  def show
    @quizz = Quizz.find(params[:id])
  end

  def update
    quizz = Quizz.find(params[:id])
    if quizz.update_attributes(quizz_params)
      render json: quizz
    else
      render json: quizz.errors
    end
  end

  private

  def quizz_params
    params.permit(:name, :public).merge(user_id: @current_user.id)
  end

end
