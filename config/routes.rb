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
      post 'upvote', :to => 'votes#create_upvote'
      post 'downvote', :to => 'votes#create_downvote'
      delete 'upvote', :to => 'votes#destroy_upvote'
      delete 'downvote', :to => 'votes#destroy_downvote'
    end
  end

  resources :votes, only: [:upvote, :downvote]
  resources :tags
  resources :curriculums do
    member do
      post 'email', to: 'curriculums#email'
    end
  end
  resources :curriculum_definitions, only: [:create, :destroy, :new]

  root to: "words#index"
end
