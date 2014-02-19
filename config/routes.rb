Wbdv465Midterm::Application.routes.draw do
  resources :books

  resources :sessions,   only: [:create]
  resources :users do
    resources :books, only: [:create, :update, :destroy], controller: :user_books
  end

  get     "signup"       => "users#new",        as: "signup"
  get     "signin"       => "sessions#new",     as: "signin"
  delete  "signout"      => "sessions#destroy", as: "signout"

  root "books#index"
end
