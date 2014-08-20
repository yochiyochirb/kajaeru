Kajaeru::Application.routes.draw do
  get "members/index"
  root "members#index"
  resources :votes, except: %i(index destroy)
end
