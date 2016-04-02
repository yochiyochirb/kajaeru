Rails.application.routes.draw do
  resources :members, only: %i(index)
  root 'members#index'

  resources :events, only: %i(index show) do
    resources :candidates, shallow: true, only: %i(index)
    resources :voters, shallow: true, only: %i(index)
    resources :votes, shallow: true, except: %i(index destroy)
    get 'votes/total'
  end

  get '/auth/:provider/callback' => 'sessions#callback'
  get '/signin'                  => 'sessions#new'
  delete '/signout'              => 'sessions#destroy'

  resource :mypage, only: :show do
    resource :vote, only: :show, controller: 'mypage/vote'
  end
end
