Rails.application.routes.draw do

  # Users
  devise_for :users, controllers: {registrations: 'users/registrations', sessions: 'users/sessions', invitations: "users/invitations" }
  patch "users/update_profile" => "users#update_profile", as: :update_profile
  patch 'users/update_existing_profile', to: 'users#update_existing_profile', as: :update_existing_profile

  # Love Languages
  resources :love_languages, only: [:new, :create]

  # Missions
  resources :missions, only: [:index, :new, :create, :destroy, :edit, :update]

  # Couple challenges/tasks
  resources :couple_challenges, only: [] do
    resources :couple_tasks, only: [:new, :create]
  end
  resources :couple_tasks, only: [:show, :edit, :update] do
    member do
      patch :mark_as_completed
    end
  end

  #  Individual challenges/tasks
  resources :individual_challenges, only: [:show] do
    resources :individual_tasks, only: [:create]
  end

  resources :individual_tasks, only: [:show] do
    member do
      patch :mark_as_completed
    end
  end

  # Events
  resources :events  do
    get '/timeline', to: 'events#timeline', on: :collection
    get 'add-memory', to: 'events#add_memory', on: :collection
  end

  # Chatroom
  resources :chatrooms, only: :show do
    resources :messages, only: [:create]
  end

  # Pages
  root to: "pages#landing"
  get '/home', to: "pages#home"
  get "edit_profile" => "users#edit_profile"
  get 'edit_existing_profile', to: 'users#edit_existing_profile'
  get '/quest_log', to: 'pages#quests'
  get '/explore_couples_challenges', to: 'pages#explore_couples_challenges'
  get '/explore_solo_challenges', to: 'pages#explore_solo_challenges'
  get '/solo_challenges_in_progress', to: 'pages#solo_challenges_in_progress'
  get '/couples_challenges_in_progress', to: 'pages#couples_challenges_in_progress'
  get '/profile', to: 'pages#profile'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
