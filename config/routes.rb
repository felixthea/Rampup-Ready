Workwiki::Application.routes.draw do
  resources :users
  resource :session
  resources :subdivisions
  resources :subdivision_managements, only: [:new, :create, :destroy]
  resources :words

  root to: "words#index"
end
