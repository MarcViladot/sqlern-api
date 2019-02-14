json.extract! @answeredquizz, :id, :note, :created_at, :updated_at
json.exercises @answeredquizz.answeredexercises.each do |exercise|
	json.(exercise, :id, :answered, :correct, :created_at, :updated_at)
	json.exercise exercise.exercise
end
json.user do 
	json.(@answeredquizz.user, :id, :name, :last_name)
end
