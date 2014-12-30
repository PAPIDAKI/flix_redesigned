Flix::Application.routes.draw do

  resources :genres

  get 'signin'=>"sessions#new"
  get 'signup'=>"users#new"
  resources :users
  resource :session

  root "movies#index"

  #get 'movies/filter/hits'=>"movies#index",scope: "hits"
  #get 'movies/filter/flops'=>"movies#index",scope:"flops"
  get 'movies/filter/:scope'=>'movies#index',as: :filtered_movies
  resources :movies do
      resources :reviews
      resources :favorites

  end

end
