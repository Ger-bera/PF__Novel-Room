Rails.application.routes.draw do

  devise_for :admins, controllers:{
    sessions:       "admin/sessions",
    passwords:     "admin/passwords",
  }

  namespace :admin do
    resources :rooms, only: [:index, :show, :destroy] do
      resources :room_comments, only: [:destroy]
      resources :novels, only: [:index, :show, :destroy] do
        resources :novel_comments, only: [:destroy]
      end
    end
  end

  devise_for :users, controllers:{
    sessions:       "public/sessions",
    passwords:     "public/passwords",
    registrations: "public/registrations"
  }

  resources :users, module: "public", only: [:show, :edit, :update] do
    member do
      get "unsubscribe"
      patch "withdraw"
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to:"public/homes#top"
  get "/about" => "public/homes#about"
  get "/search" => "searches#search"

  resources :notifications, only: :index
  get "/all_novels" => "public/novels#all_index"

  resources :rooms, module: "public" do
    resources :room_comments    , only: [:create, :destroy]
    resources :room_favorites   , only: [:create, :destroy]
    resources :novels do
      resource :bookmarks, only: [:create, :destroy]
      resources :novel_comments , only: [:create, :destroy]
      resources :novel_favorites, only: [:create, :destroy]
    end
  end
end
