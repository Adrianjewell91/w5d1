Rails.application.routes.draw do

  resources :users, only: [:new, :create, :show, :index] do
    resources :goals, only: [:index, :create]
  end

  resources :goals

  resource :session, only: [:new, :create, :destroy]
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "sessions#new"
end
