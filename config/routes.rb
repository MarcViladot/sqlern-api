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



end
