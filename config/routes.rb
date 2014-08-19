Kajaeru::Application.routes.draw do
  resources :votes, except: %i(index destroy)
end
