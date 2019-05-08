require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam accumsan posuere justo quis sagittis. Quisque tempus tellus dui, finibus porta nisl placerat sed. Etiam sed tincidunt mi. Suspendisse aliquam nisi eget velit gravida, eu laoreet quam mattis. Proin vitae volutpat magna. Fusce porta vel lectus quis aliquet. Integer nunc lorem, elementum quis tellus ut, rhoncus fringilla purus. Mauris lacinia urna lacinia dolor sollicitudin, quis egestas nunc venenatis. Aliquam quis nunc sollicitudin purus aliquam molestie quis non tortor. Aenean auctor elit ut interdum pretium. Sed condimentum lacus nec lectus ultrices, sit amet iaculis ligula ultrices. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Quisque vehicula volutpat nulla, et commodo justo vestibulum sed. Vestibulum vitae convallis sapien."
lorem_html = "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse sit amet mi id mauris ornare fermentum. Nam elit leo, pretium in sem eget, maximus venenatis lectus. Maecenas sagittis et purus vel pretium. Mauris id nisi condimentum, volutpat eros eu, fringilla justo. Phasellus tincidunt lacinia odio, quis rutrum nibh. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Donec pharetra ultrices fermentum. Cras arcu felis, ullamcorper non eros et, auctor ultricies mi.</p>
<p>Maecenas sollicitudin elementum ante, eget consectetur felis. Sed et suscipit mauris, vitae tempus velit. Fusce nisi metus, suscipit tincidunt pretium in, aliquam id orci. Sed vel risus aliquam, gravida urna nec, sollicitudin tortor. Vivamus dictum odio eu est feugiat, id tincidunt est dictum. Praesent ac elit egestas orci semper suscipit quis in odio. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Aenean finibus orci at quam accumsan ultrices. Integer ac tortor a ipsum convallis hendrerit id non ligula. Nullam tincidunt massa vel odio hendrerit accumsan. Vestibulum ac turpis lobortis, aliquam velit et, tincidunt massa.</p>"
solution = "SELECT *
FROM guests"

User.create(name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: 'tanja@hotmail.com', role: 1, 'email_confirmed': 1, password: '12345', password_confirmation: '12345')
10.times do
  User.create(name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.free_email, role: 1, password: '12345', password_confirmation: '12345')
end

User.create(name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: 'marcviladot@hotmail.com', role: 0, 'email_confirmed': 1, password: '12345', password_confirmation: '12345') #12
10.times do
  User.create(name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.free_email, role: 0, password: '12345', password_confirmation: '12345')
end


Topic.create([{name: 'Subquery'}, {name: 'Joins'}, {name: 'Order'}, {name: 'Group'}, {name: 'Where'},
              {name: 'Count'}, {name: 'AVG'}, {name: 'Having'}, {name: 'Union'}, {name: 'Between'}])

Conceptualmodel.create([{name: 'model 1', url: 'https://res.cloudinary.com/dpsci3hpd/image/upload/v1547994386/cm.png', user_id: 1},
                        {name: 'model 2', url: 'https://res.cloudinary.com/dpsci3hpd/image/upload/v1556269508/data-center-relational-model.png', user_id: 1}])

200.times do |i|
  user = rand(1..10)
  Exercise.create({statement: Faker::Lorem.paragraph, public: true, solution: solution, user_id: user, conceptualmodel_id: rand(1..2)})
  Comment.create({comment: Faker::Lorem.sentence, user_id: user, exercise_id: i+1})
  Topicexercise.create([{topic_id: rand(1..10), exercise_id: i+1},
                        {topic_id: rand(1..10), exercise_id: i+1},
                        {topic_id: rand(1..10), exercise_id: i+1}
                        ])
end

20.times do |i|
  Quizz.create({name: Faker::Lorem.sentence, public: true, user_id: rand(1..10)})
  Topicquizz.create([{topic_id: rand(1..10), quizz_id: i+1},
                     {topic_id: rand(1..10), quizz_id: i+1},
                     {topic_id: rand(1..10), quizz_id: i+1}
                     ])
end

20.times do |i|
  Quizzexercise.create([{exercise_id: rand(1..200), quizz_id: i+1},
                        {exercise_id: rand(1..200), quizz_id: i+1},
                        {exercise_id: rand(1..200), quizz_id: i+1},
                        {exercise_id: rand(1..200), quizz_id: i+1},
                        {exercise_id: rand(1..200), quizz_id: i+1},
                        {exercise_id: rand(1..200), quizz_id: i+1},
                        {exercise_id: rand(1..200), quizz_id: i+1},
                        {exercise_id: rand(1..200), quizz_id: i+1},
                        {exercise_id: rand(1..200), quizz_id: i+1},
                        {exercise_id: rand(1..200), quizz_id: i+1}])
end


5.times do |i|
  Generatedquizz.create({user_id: 1, quizz_id: i+1})
end


100.times do |i|
  Answeredexercise.create({answered: solution, correct: true, exercise_id: rand(1..200), user_id: rand(12..20)})
end


11.times do |i|
  Answeredquizz.create({note: 10, generatedquizz_id: rand(1..5), user_id: rand(12..20)})
end

12.upto(20) do
  10.times do |x|
    Joinanswered.create({answeredexercise_id: rand(1..100), answeredquizz_id: x+1})
  end
end
