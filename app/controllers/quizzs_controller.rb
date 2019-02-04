class QuizzsController < ApplicationController

  api :GET, "/quizzs", "Show all the quizzs"
  def index
    quizzs = Quizz.all
    render json: quizzs
  end

  # api :POST, "/quizzs", "Create quizz"
  # param :name, String, desc: 'name of the quizz', :required => true
  # param :solution, String, desc: 'solution of the exercise', :required => true
  # param :public, :boolean, desc: 'exercise is public', :required => true
  # param :conceptualmodel_id, :number, desc: 'id of the conceptual model', :required => true
  # header 'Authorization', 'Auth header', :required => true
  def create
    quizz = Quizz.new(quizz_params)
    if quizz.save
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

  def destroy
    quizz = Quizz.find(params[:id])
    quizz.destroy
    render json: quizz
  end

  api :GET, "/quizz/set/:topics", "Find quizzs by topics"
  param :topics, String, desc: 'topics of the exercises', :required => true
  header 'Authorization', 'Auth header', :required => true
  def index_set
    topics = params[:topics].split("+")
    @quizzs = Quizz.joins(:topics).where("topics.name IN (?) AND quizzs.public = true AND quizzs.user_id != ?", topics, @current_user.id).uniq
  end

  def show
    @quizz = Quizz.find(params[:id])
    # render json: quizz
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
