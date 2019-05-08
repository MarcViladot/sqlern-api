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
	json.last_quizz do
		last_quizz = @user.generatedquizzs[-1]
		min_note = last_quizz.quizz.exercises.length.to_f / 2.0
		json.quizz_code last_quizz.code
		json.correct last_quizz.answeredquizzs.count{ |quizz| quizz[:note] >= min_note }.to_i
		json.incorrect last_quizz.answeredquizzs.count{ |quizz| quizz[:note] < min_note }.to_i
	end
	list = Hash.new
	@user.quizzs.each do |quizz|
		list[quizz.name] = quizz.generatedquizzs.count.to_i
	end
	json.quizz_list list

	gquizz_list = Hash.new
	@user.generatedquizzs.each do |gquizz|
		gquizz_list[gquizz.code] = gquizz.answeredquizzs.count.to_i
	end
	json.gquizz_list gquizz_list
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
		json.correct @user.answeredexercises.count{ |exercise| exercise[:correct] == true }.to_i
		json.incorrect @user.answeredexercises.count{ |exercise| exercise[:correct] == false }.to_i
	end
	array = Array.new
	0.upto(10) do |i|
		total = @user.answeredquizzs.count{|quizz| quizz[:note].to_f / quizz.generatedquizz.quizz.exercises.size * 10 >= i && quizz[:note].to_f / quizz.generatedquizz.quizz.exercises.size * 10 < i + 1}.to_i
		array.push(total)
	end
	json.answered_quizzs do 
		json.resume array
		json.correct @user.answeredquizzs.count{|quizz| quizz[:note].to_f / quizz.generatedquizz.quizz.exercises.size * 10 >= 5}.to_i
		json.incorrect @user.answeredquizzs.count{|quizz| quizz[:note].to_f / quizz.generatedquizz.quizz.exercises.size * 10 < 5}.to_i
	end
	topics = Hash.new
	incorrect_exercises = @user.answeredexercises.select{|exercise| exercise[:correct] == false}
	incorrect_exercises.each do |exercise|
		exercise.exercise.topics.each do |topic|
			if topics[topic.name].nil?
				topics[topic.name] = 1
			else 
				topics[topic.name] += 1
			end 
		end
	end
	json.failed_topics topics
end 

























