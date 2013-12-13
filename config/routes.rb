Workwiki::Application.routes.draw do
  resources :users do
    collection do
      get 'bulk_new', to: 'users#bulk_new'
      post 'bulk_add', to: 'users#bulk_add'
    end
  end

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
      get 'email', :to => 'definitions#new_email_definition'
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
  resources :messages

  root to: "words#index"
end
