Kajaeru::Application.routes.draw do
  resources :members, only: %i(index)
  root 'members#index'
  resources :votes, except: %i(index destroy)

  get '/auth/:provider/callback' => 'sessions#callback'
  get '/signout'                 => 'sessions#destroy'
end