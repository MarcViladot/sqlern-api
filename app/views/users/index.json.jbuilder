json.extract! @user, :id, :name, :last_name, :email, :role, :created_at, :updated_at
if @user.role == 1 #Teacher
	json.exercises @user.exercises do |exercise|
		json.(exercise, :id, :solution, :statement, :public, :conceptualmodel_id, :created_at, :updated_at)
		json.topics exercise.topics
		json.comments exercise.comments
		json.user do
			json.(exercise.user, :id, :name, :last_name)
		end
	end
	json.comments @user.comments
	json.quizzs @user.quizzs
	json.conceptualmodels @user.conceptualmodels
	json.generatedquizzs @user.generatedquizzs
else
	json.exercises @user.answeredexercises
	json.quizzs @user.answeredquizzs
end 

