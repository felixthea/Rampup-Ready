Workwiki::Application.routes.draw do
  resources :users
  resource :session
  resources :subdivisions
end
