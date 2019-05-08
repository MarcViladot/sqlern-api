json.extract! @answeredquizz, :id, :note, :created_at, :updated_at
json.exercises @answeredquizz.answeredexercises.each do |exercise|
	json.(exercise, :id, :answered, :correct, :created_at, :updated_at)
	#json.exercise exercise.exercise
	json.exercise do
		json.(exercise.exercise, :id, :statement, :solution, :public, :created_at, :updated_at)
		json.conceptualmodel exercise.exercise.conceptualmodel
	end
end
json.user do 
	json.(@answeredquizz.user, :id, :name, :last_name)
end
