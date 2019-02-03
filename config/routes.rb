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
  get 'exercises/set/intelligent/', to: 'exercises#index_set_intelligent'
  get 'exercises/set/:limit/:topics', to: 'exercises#index_set'




end
