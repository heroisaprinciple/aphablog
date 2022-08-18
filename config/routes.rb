Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'pages#home'
  get 'about', to: 'pages#about'
  get 'articles', to: 'articles#show'
  get 'articles/', to: 'articles#index'
  resources :articles #only: [:...] # searching for all routes, only specifies the necessary route

end
