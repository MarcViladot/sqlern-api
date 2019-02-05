json.array!(@quizzs.sort_by{ rand }) do |quizz|
	json.extract! quizz, :id, :name, :public, :created_at, :updated_at
	json.topics quizz.topics
	json.votes quizz.quizz_votes.count.to_i
	json.upvoted false
	quizz.quizz_votes.each do |vote|
		json.upvoted true if vote.user.id == @current_user.id
	end
	json.exercises quizz.exercises do |exercise|
		json.(exercise, :id, :statement, :solution, :public, :created_at, :updated_at)
		json.conceptualmodel exercise.conceptualmodel
		json.comments exercise.comments do |comment|
			json.(comment, :id, :comment)
		end
		json.topics exercise.topics
		json.user do
			json.(exercise.user, :id, :name, :last_name)
		end
	end
	json.user do
		json.(quizz.user, :id, :name, :last_name)
	end
end