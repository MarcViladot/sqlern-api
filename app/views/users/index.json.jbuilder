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
	json.exercises do
		json.array!(@user.answeredexercises.sort_by{|o| o.created_at}.reverse!) do |exercise|
			json.(exercise, :id, :answered, :correct, :created_at, :updated_at)
			json.exercise do
				json.(exercise.exercise, :id, :solution, :statement, :public, :conceptualmodel_id, :created_at, :updated_at)
				json.topics exercise.exercise.topics
				json.comments exercise.exercise.comments
				json.user do
					json.(exercise.exercise.user, :id, :name, :last_name)
				end
			end
		end
	end
	json.quizzs do
		json.array!(@user.answeredquizzs.sort_by{|o| o.created_at}.reverse!) do |aquizz|
			json.(aquizz, :id, :note, :created_at)
			json.length aquizz.generatedquizz.quizz.exercises.length
			json.gquizz do
				json.(aquizz.generatedquizz, :id, :code, :created_at)
				json.user do
					json.(aquizz.generatedquizz.user, :id, :name, :last_name)
				end
			end
		end
	end
end 

