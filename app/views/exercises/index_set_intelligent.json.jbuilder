json.array!(@exercises.sort_by{ rand }) do |exercise|
	json.extract! exercise, :id, :statement, :solution, :public, :created_at, :updated_at
	json.conceptualmodel exercise.conceptualmodel
	json.comments exercise.comments do |comment|
		json.(comment, :id, :comment)
	end
	json.topics exercise.topics
end