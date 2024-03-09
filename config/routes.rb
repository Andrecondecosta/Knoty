Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'users/registrations', sessions: 'users/sessions', invitations: "users/invitations" }
  root to: "pages#home"


  resources :love_languages, only: [:new, :create]
  resources :individual_challenges, only: [:show]
  resources :missions, only: [:index, :new, :create, :destroy, :edit, :update]
  resources :couple_tasks, only: [:show]

  resources :couple_challenges, only: [:show] do
    resources :couple_tasks, only: [:create]
  end
  get "edit_profile" => "users#edit_profile"
  get '/quest_log', to: 'pages#quests'
  get '/profile', to: 'pages#profile'
  patch "users/update_profile" => "users#update_profile", as: :update_profile
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
