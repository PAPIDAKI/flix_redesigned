Flix::Application.routes.draw do

  get 'signin'=>"sessions#new"
  get 'signup'=>"users#new"
  resources :users
  resource :session

  root "movies#index"

  resources :movies do
      resources :reviews
      resources :favorites

  end

end
