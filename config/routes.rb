Workwiki::Application.routes.draw do
  resources :users do
    collection do
      get 'bulk_new', to: 'users#bulk_new'
      post 'bulk_add', to: 'users#bulk_add'
      get 'add_more', to: 'users#add_more'
      get 'valid_email', to: 'users#valid_email'
    end
  end

  resources :companies, only: [:new, :create, :destroy]
  get "start", to: "companies#new"
  resource :session, only: [:new, :create, :destroy]
  resources :subdivisions
  resources :subdivision_managements, only: [:new, :create, :destroy]
  resources :words do
    resources :definitions, only: [:create, :index]
  end

  resources :definitions, only: [:edit, :destroy, :update, :create] do
    member do
      post 'upvote', :to => 'votes#create_upvote'
      post 'downvote', :to => 'votes#create_downvote'
      delete 'upvote', :to => 'votes#destroy_upvote'
      delete 'downvote', :to => 'votes#destroy_downvote'
      get 'email', :to => 'definitions#new_email_definition'
      post 'favorite', to: 'definition_faves#favorite'
      delete 'unfavorite', to: 'definition_faves#unfavorite'
    end
  end

  resources :votes, only: [:upvote, :downvote]
  resources :tags
  resources :curriculums do
    member do
      post 'email', to: 'curriculums#email'
      post 'favorite', to: 'curriculum_faves#favorite'
      delete 'unfavorite', to: 'curriculum_faves#unfavorite'
    end
  end
  resources :curriculum_definitions, only: [:create, :destroy, :new]
  resources :messages do
    collection do
      get 'sent', :to => 'messages#sent_index'
    end
  end

  get 'favorites', to: 'users#favorites'
  get 'forgot_password', to: 'users#forgot_password'
  post 'send_forgot_password_email', to: 'users#send_forgot_password_email'
  get 'set_new_password', to: 'users#set_new_password'
  post 'update_password', to: 'users#update_password'
  resource :search, only: [:new, :create, :destroy]
  root to: "static_pages#index"
  get 'notify_recipient', to: 'inbound#notify_recipient'

  resources :static_pages, only: [:index]
  get 'invite', to: 'invites#new'
  post 'invite', to: 'invites#create'
  get 'invite/rsvp', to: 'invites#rsvp'
  get 'invite/employees', to: 'invites#new_employees'
  post 'invite/employees', to: 'invites#create_employees'
end
