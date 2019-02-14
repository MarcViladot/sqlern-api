json.extract! @quizz, :id, :name, :public, :created_at, :updated_at
json.user do 
	json.(@quizz.user, :id, :name, :last_name)
end
json.exercises @quizz.quizzexercises do |quizz_exercise|
	json.(quizz_exercise.exercise, :id, :statement, :public, :solution)
	json.conceptualmodel quizz_exercise.exercise.conceptualmodel
	json.topics quizz_exercise.exercise.topics
	json.comments quizz_exercise.exercise.comments do |comment|
		json.(comment, :id, :comment)
	end
end
json.generated false
@quizz.generatedquizzs.each do |generated|
	json.generated true if generated.user.id == @current_user.id
end
