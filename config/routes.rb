Workwiki::Application.routes.draw do
  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :subdivisions
  resources :subdivision_managements, only: [:new, :create, :destroy]
  resources :words do
    resources :definitions, only: [:create, :index]
  end

  resources :definitions, only: [:show, :edit, :destroy, :update] do
    member do
      post 'upvote', :to => 'votes#upvote'
      post 'downvote', :to => 'votes#downvote'
    end
  end

  resources :votes, only: [:upvote, :downvote]

  root to: "words#index"
end
