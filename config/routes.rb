Workwiki::Application.routes.draw do
  resources :users
  resource :session
  resources :subdivisions
  resources :subdivision_managements, only: [:new, :create, :destroy]
  resources :words do
    resources :definitions, only: [:create, :index]
  end

  resources :definitions, only: [:show, :edit, :destroy, :update]

  root to: "words#index"
end
