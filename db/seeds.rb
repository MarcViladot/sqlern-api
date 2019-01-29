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
User.create(name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: 'marcviladot@hotmail.com', role: 0, 'email_confirmed': 1, password: '12345', password_confirmation: '12345')
4.times do
  User.create(name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.free_email, role: 1, password: '12345', password_confirmation: '12345')
end

4.times do
  User.create(name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.free_email, role: 0, password: '12345', password_confirmation: '12345')
end


Topic.create([{name: 'Subquery'}, {name: 'Joins'}, {name: 'Order'}, {name: 'Group'}, {name: 'Where'}])

Conceptualmodel.create({url: 'https://res.cloudinary.com/dpsci3hpd/image/upload/v1547994386/cm.png', user_id: 1})

Exercise.create([
                  {statement: Faker::Lorem.paragraph, public: true, solution: solution, user_id: 1, conceptualmodel_id: 1},
                  {statement: Faker::Lorem.paragraph, public: true, solution: solution, user_id: 1, conceptualmodel_id: 1},
                  {statement: Faker::Lorem.paragraph, public: true, solution: solution, user_id: 1, conceptualmodel_id: 1},
                  {statement: Faker::Lorem.paragraph, public: true, solution: solution, user_id: 1, conceptualmodel_id: 1},
                  {statement: Faker::Lorem.paragraph, public: true, solution: solution, user_id: 1, conceptualmodel_id: 1},
                  {statement: Faker::Lorem.paragraph, public: true, solution: solution, user_id: 1, conceptualmodel_id: 1},
                  {statement: Faker::Lorem.paragraph, public: true, solution: solution, user_id: 1, conceptualmodel_id: 1},
                  {statement: Faker::Lorem.paragraph, public: true, solution: solution, user_id: 1, conceptualmodel_id: 1},
                  {statement: Faker::Lorem.paragraph, public: true, solution: solution, user_id: 1, conceptualmodel_id: 1},
                  {statement: Faker::Lorem.paragraph, public: true, solution: solution, user_id: 1, conceptualmodel_id: 1}
])

Topicexercise.create([
                       {topic_id: 2, exercise_id: 1},
                       {topic_id: 3, exercise_id: 1},
                       {topic_id: 1, exercise_id: 2},
                       {topic_id: 2, exercise_id: 2},
                       {topic_id: 1, exercise_id: 3},
                       {topic_id: 3, exercise_id: 3},
                       {topic_id: 2, exercise_id: 4},
                       {topic_id: 5, exercise_id: 4},
                       {topic_id: 2, exercise_id: 5},
                       {topic_id: 2, exercise_id: 6},
                       {topic_id: 1, exercise_id: 7},
                       {topic_id: 2, exercise_id: 8},
                       {topic_id: 3, exercise_id: 9},
                       {topic_id: 4, exercise_id: 10}
])

Comment.create([
                 {comment: Faker::Lorem.sentence, user_id: 1, exercise_id: 1},
                 {comment: Faker::Lorem.sentence, user_id: 1, exercise_id: 1},
                 {comment: Faker::Lorem.sentence, user_id: 1, exercise_id: 2},
                 {comment: Faker::Lorem.sentence, user_id: 1, exercise_id: 3},
                 {comment: Faker::Lorem.sentence, user_id: 1, exercise_id: 4}
])

Quizz.create([
               {name: Faker::Lorem.sentence, public: true, user_id: 1}
])

Quizzexercise.create([
                       {exercise_id: 1, quizz_id: 1},
                       {exercise_id: 2, quizz_id: 1},
                       {exercise_id: 3, quizz_id: 1},
                       {exercise_id: 4, quizz_id: 1},
                       {exercise_id: 5, quizz_id: 1},
                       {exercise_id: 6, quizz_id: 1},
                       {exercise_id: 7, quizz_id: 1},
                       {exercise_id: 8, quizz_id: 1},
                       {exercise_id: 9, quizz_id: 1},
                       {exercise_id: 10, quizz_id: 1}
])

Generatedquizz.create(user_id: 2, quizz_id: 1)
