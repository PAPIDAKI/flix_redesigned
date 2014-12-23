Flix::Application.routes.draw do
  resources :favorites

  get 'signin'=>"sessions#new"
  get 'signup'=>"users#new"
  resources :users
  resource :session

  root "movies#index"
  resources :movies do
      resources :reviews
    end

end
