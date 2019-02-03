class QuizzsController < ApplicationController

  api :GET, "/quizzs", "Show all the quizzs"
  def index
    quizzs = Quizz.all
    render json: quizzs
  end

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
