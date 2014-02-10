Wbdv465Midterm::Application.routes.draw do
  resources :books
  resources :lists

  resources :sessions,   only: [:create]
  resources :users

  get     "tags/:tag"    => "books#index",      as: :tag
  get     "signup"       => "users#new",        as: "signup"
  get     "signin"       => "sessions#new",     as: "signin"
  delete  "signout"      => "sessions#destroy", as: "signout"

  root "books#index"
end
