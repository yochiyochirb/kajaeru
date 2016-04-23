Rails.application.routes.draw do
  resources :members, only: %i(index)
  root 'members#index'

  resources :events, only: %i(index show) do
    resources :candidates, only: %i(index)
    resources :votes, except: %i(index destroy) do
      get 'total', on: :collection
    end
  end

  get '/auth/:provider/callback' => 'sessions#callback'
  get '/signin'                  => 'sessions#new'
  delete '/signout'              => 'sessions#destroy'

  resource :mypage, only: :show do
    resource :vote, only: :show, controller: 'mypage/vote'
  end
end
