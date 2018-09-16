Rails.application.routes.draw do

  get '/schedules/top', to: 'schedules#top'
  root 'schedules#top'
  devise_for :users

  resources :users, only: [:index, :show] do
    member do
      get :following, :followers
    end
  end

  resources :schedules do
    resources :comments
    collection do
      post :confirm
    end
  end

  resources :favorites, only: [:create, :destroy]

  resources :follows, only: [:create, :destroy]
  
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
end
