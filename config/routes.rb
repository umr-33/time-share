Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'users#show'

  resources :users, only: [:index, :edit, :update, :show]
  resources :groups, only: [:new, :create, :edit, :update, :show] do
    resources :events, only: [:new, :edit, :show, :create, :destroy]
  end
end
