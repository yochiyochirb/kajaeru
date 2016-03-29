Rails.application.routes.draw do
  resources :members, only: %i(index)
  root 'members#index'
  get 'votes/total'
  resources :votes, except: %i(index destroy)

  resources :events, only: %i(index show) do
    resources :candidates, shallow: true, only: %i(index)
    resources :voters, shallow: true, only: %i(index)
  end

  get '/auth/:provider/callback' => 'sessions#callback'
  get '/signin'                  => 'sessions#new'
  delete '/signout'              => 'sessions#destroy'

  resource :mypage, only: :show do
    resource :vote, only: :show, controller: 'mypage/vote'
  end
end
