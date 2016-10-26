Rails.application.routes.draw do
  resources :games, except: [:new, :edit, :destroy]
  # this is the streaming interface
  get '/games/:id/watch' => 'games#watch'

  post '/sign-up' => 'users#signup'
  post '/sign-in' => 'users#signin'
  delete '/sign-out/:id' => 'users#signout'
  patch '/change-password/:id' => 'users#changepw'
  resources :users, only: [:index, :show]
end
