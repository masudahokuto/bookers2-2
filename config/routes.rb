Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  get 'about', to:'homes#about', as:'about'
  resources :users, only: [:show, :index, :edit, :update]
  resources :books, only: [:show, :index, :edit, :create, :destroy, :update,]
end
