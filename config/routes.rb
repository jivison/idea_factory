Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "ideas#index"

  resources :ideas do
    resources :reviews, shallow: true, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy], shallow: true
  end

  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]

end
