json.extract! @generatedquizz, :id, :code, :created_at, :updated_at
json.quizz do 
		json.(@generatedquizz.quizz, :id, :name, :public, :created_at, :updated_at)
		json.exercises @generatedquizz.quizz.quizzexercises do |quizz_exercise|
		json.(quizz_exercise.exercise, :id, :statement, :public, :solution)
		json.conceptualmodel quizz_exercise.exercise.conceptualmodel
		json.topics quizz_exercise.exercise.topics
		json.comments quizz_exercise.exercise.comments do |comment|
			json.(comment, :id, :comment)
		end
	end
end
if @current_user.role == 1 #Teacher
	json.student_answers @generatedquizz.answeredquizzs do |aquizz|
		json.(aquizz, :id, :note, :created_at)
		json.length @generatedquizz.quizz.exercises.length
		json.user do 
			json.(aquizz.user, :id, :name, :last_name)
		end
	end
end


