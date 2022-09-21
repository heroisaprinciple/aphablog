Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'pages#home'
  get 'about', to: 'pages#about'
  resources :articles, only: [:show, :index, :new, :create, :edit, :update, :destroy] # searching for all routes, only specifies the necessary route
  # resources when you need /articles and then /articles/1 and etc (using REST)

  get 'signup', to: 'users#new'
  # post, patch, delete requests for users all in one, except the /signup route
  # because we already have our new controller used
  resources :users, except: [:new]

  # for login
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

end
