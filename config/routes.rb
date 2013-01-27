EwhaNote::Application.routes.draw do
  devise_for :users, controllers: { sessions: 'user_sessions' }

  resources :lectures do
    get :search, on: :collection
    resources :assessments
  end

  resources :assessments
  resources :registrations, only: [:new, :create]

  root :to => 'assessments#index'
end
