Rails.application.routes.draw do
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

  #Application
  post 'create-tables', to: 'tables#create_tables'

  #GeneratedQuizzs
  get 'generatedquizzs/code/:code', to: 'generatedquizzs#show_by_code'

  #Exercises
  get 'exercises/set/:limit/:topics', to: 'exercises#index_set'



end
