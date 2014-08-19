Kajaeru::Application.routes.draw do

  get "members/index"

  root 'members#index'

  resources :votes, except: %w(index destroy)
end
