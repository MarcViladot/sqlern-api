json.extract! @user, :id, :name, :last_name, :email, :role, :created_at, :updated_at
if @user.role == 1 #Teacher
	json.exercises @user.exercises
	json.comments @user.comments
	json.quizzs @user.quizzs
	json.conceptualmodels @user.conceptualmodels
	json.generatedquizzs @user.generatedquizzs
else
	json.exercises @user.answeredexercises
	json.quizzs @user.answeredquizzs
end 

