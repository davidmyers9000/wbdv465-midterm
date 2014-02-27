Wbdv465Midterm::Application.routes.draw do

  resources :authors do
    resources :reviews, except: :show, controller: "authors/reviews"
  end
  resources :books do
    resources :reviews, except: :show, controller: "books/reviews"
  end
  resources :genres,      only: [:show]
  resources :sessions,    only: [:create]
  resources :users do
    resources :books,       only: [:create, :update, :destroy], controller: :user_books
    resources :reviews,     only: [:index], controller: "users/reviews"
  end

  get     "signup"       => "users#new",        as: "signup"
  get     "signin"       => "sessions#new",     as: "signin"
  delete  "signout"      => "sessions#destroy", as: "signout"

  root "books#index"
end
