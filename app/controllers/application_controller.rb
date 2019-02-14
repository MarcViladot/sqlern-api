class ApplicationController < ActionController::API
  include ActionController::ImplicitRender
  include ActionController::Helpers

  # before_action :set_database, :set_current_user, :authenticate_request
  before_action :set_current_user, :authenticate_request
  helper_method :authenticate_confirmed_user, :authenticate_teacher, :authenticate_student, :authenticate_admin

  def authenticate_confirmed_user
    unless @current_user.email_confirmed == true
      render json: {error: 'Not Authorized'}, status: :unauthorized
    end
  end

  def correct_exercise(exercise_id, student_solution)
    connection = ActiveRecord::Base.establish_connection(:development)
    solution = Exercise.find(exercise_id).solution
    ActiveRecord::Base.remove_connection(connection)

    base = ActiveRecord::Base.establish_connection(:development_aux)
    begin
      student_solution = base.connection.execute(student_solution).first
      teacher_solution = base.connection.execute(solution).first
      correct = student_solution.size == teacher_solution.size and ((student_solution - teacher_solution) + (teacher_solution - student_solution)).blank?
      ActiveRecord::Base.remove_connection(base)
    rescue
      correct = false
    end
    ActiveRecord::Base.establish_connection(:development)
    correct
  end

  private

  def set_database
    ActiveRecord::Base.establish_connection(:development)
  end

  def authenticate_teacher
    unless @current_user.role == 1
      render json: {error: 'Not Authorized'}, status: :unauthorized
    end
  end

  def authenticate_student
    unless @current_user.role == 0
      render json: {error: 'Not Authorized'}, status: :unauthorized
    end
  end

  def authenticate_admin
    unless @current_user.role == 3
      render json: {error: 'Not Authorized'}, status: :unauthorized
    end
  end

  def set_current_user
    if decoded_auth_token
      @current_user = User.find(decoded_auth_token[:user_id])
    end
  end

  def decoded_auth_token
    if request.headers['Authorization'].present?
      token = request.headers['Authorization'].split(' ').last
      JsonWebToken.decode(token)
    end
  end

  def authenticate_request
    unless @current_user
      render json: {error: 'Not Authorized'}, status: :unauthorized
    end
  end

end
