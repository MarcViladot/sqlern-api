Rails.application.routes.draw do
  apipie
  resources :exercises
  resources :answeredexercises
  resources :answeredquizzs
  resources :comments
  resources :conceptualmodels
  resources :generatedquizzs
  resources :joinanswereds
  resources :quizzexercises
  resources :quizzs
  resources :topicexercises
  resources :topics
  resources :users do
    member do
      get :confirm_email
    end
  end


  #Auth
  post 'authenticate', to: 'authentication#authenticate'

  #Tables
  post 'create-tables', to: 'tables#create_tables'
  get 'show-tables', to: 'tables#show_tables'

  #GeneratedQuizzs
  get 'generatedquizzs/code/:code', to: 'generatedquizzs#show_by_code'

  #Exercises
  get 'exercises/set/publics', to: 'exercises#index_public'
  get 'exercises/set/publics/:limit', to: 'exercises#index_set_public'
  get 'exercises/set/intelligent/', to: 'exercises#index_set_intelligent'
  get 'exercises/set/:limit/:topics', to: 'exercises#index_set'

  #Quizzs
  get 'quizzs/set/:topics/:name', to: 'quizzs#index_set'
  post 'quizzs/upvote/:quizz_id', to: 'quizzs#upvote'
  delete 'quizzs/downvote/:quizz_id', to: 'quizzs#downvote'

  #Answered Exercices
  post 'asd', to: 'answeredexercises#test'

  #Answered Quizzs
  get 'answeredquizzs/answered/:code', to: 'answeredquizzs#is_answered'



end
