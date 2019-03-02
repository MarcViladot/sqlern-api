json.extract! @user, :id, :name, :last_name, :email, :role, :created_at, :updated_at
if @user.role == 1 #Teacher
	json.exercises @user.exercises do |exercise|
		json.(exercise, :id, :solution, :statement, :public, :conceptualmodel_id, :created_at, :updated_at)
		json.topics exercise.topics
		json.comments exercise.comments
		json.conceptualmodel exercise.conceptualmodel
		json.user do
			json.(exercise.user, :id, :name, :last_name)
		end
	end
	json.comments @user.comments
	json.quizzs @user.quizzs.each do |quizz|
		json.(quizz, :id, :name, :public, :created_at, :updated_at)
		json.gtimes quizz.generatedquizzs.count.to_i
	end
	json.conceptualmodels @user.conceptualmodels
	json.generatedquizzs do
		json.array!(@user.generatedquizzs.sort_by{|o| o.created_at}.reverse!) do |gquizz|
			json.(gquizz, :id, :code, :created_at)
			json.answers gquizz.answeredquizzs.count.to_i
			json.user do
				json.(gquizz.user, :id, :name, :last_name)
			end
			json.answeredquizzs gquizz.answeredquizzs.each do |aquizz|
				json.(aquizz, :id, :note, :created_at)
				json.length aquizz.generatedquizz.quizz.exercises.length
				json.user do
					json.(aquizz.user, :id, :name, :last_name)
				end
			end
		end
	end
else #Student
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
	json.answereds do
		json.correct @user.answeredexercises.select{ |exercise| exercise[:correct] == true }.count.to_i
		json.incorrect @user.answeredexercises.select{ |exercise| exercise[:correct] == false }.count.to_i
	end
end 

