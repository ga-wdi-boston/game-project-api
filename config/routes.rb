# frozen_string_literal: true

Rails.application.routes.draw do
  # m,n,k-game routes.

  # /mnk-games.
  # Creates an m,n,k-game.  m, n, and k need to be specified.
  resources :mnk_games, except: :destroy, path: 'mnk-games'

  # /games.
  # Creates a 3,3,3-game for backward compatiblity.
  resources :games, except: %i[create destroy], controller: 'mnk_games'
  post '/games', to: 'mnk_games#create',
                 defaults: { game: { m: 3, n: 3, k: 3 } }

  # /gomoku.
  # Creates a 15,15,3-game.
  resources :gomoku, except: %i[create destroy], controller: 'mnk_games'
  post '/gomoku', to: 'mnk_games#create',
                  defaults: { game: { m: 15, n: 15, k: 5 } }

  # /tic-tac-toe.
  # Creates a 3,3,3-game.
  resources :tic_tac_toe, except: %i[create destroy],
                          controller: 'mnk_games',
                          path: 'tic-tac-toe'
  post '/tic-tac-toe', to: 'mnk_games#create',
                       defaults: { game: { m: 3, n: 3, k: 3 } }

  # this is the streaming interface
  get '/mnk-games/:id/watch' => 'mnk_games#watch'
  get '/games/:id/watch' => 'mnk_games#watch'
  get '/gomoku/:id/watch' => 'mnk_games#watch'
  get '/tic-tac-toe/:id/watch' => 'mnk_games#watch'

  post '/sign-up' => 'users#signup'
  post '/sign-in' => 'users#signin'
  delete '/sign-out/:id' => 'users#signout'
  patch '/change-password/:id' => 'users#changepw'
  resources :users, only: %i[index show]
end
