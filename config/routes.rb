Kajaeru::Application.routes.draw do
  resources :members, only: %i(index)
  root 'members#index'
  resources :votes, except: %i(index destroy)
end
