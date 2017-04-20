# frozen_string_literal: true

Rails.application.routes.draw do
  resources :games, except: :destroy, controller: 'mnk_games'
  # this is the streaming interface
  get '/games/:id/watch' => 'mnk_games#watch'

  post '/sign-up' => 'users#signup'
  post '/sign-in' => 'users#signin'
  delete '/sign-out/:id' => 'users#signout'
  patch '/change-password/:id' => 'users#changepw'
  resources :users, only: %i[index show]
end
