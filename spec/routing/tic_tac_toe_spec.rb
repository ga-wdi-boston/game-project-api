# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'routes for tic-tac-toe' do
  it 'routes GET /tic-tac-toe to mnk_games#index' do
    expect(get('/tic-tac-toe')).to route_to(
      controller: 'mnk_games',
      action: 'index'
    )
  end

  it 'routes GET /tic-tac-toe/:id to mnk_games#show' do
    expect(get('/tic-tac-toe/1')).to route_to(
      controller: 'mnk_games',
      action: 'show',
      id: '1'
    )
  end

  it 'routes GET /tic-tac-toe/:id/watch to mnk_games#watch' do
    expect(get('/tic-tac-toe/1/watch')).to route_to(
      controller: 'mnk_games',
      action: 'watch',
      id: '1'
    )
  end

  it 'routes POST /tic-tac-toe to mnk_games#create' do
    expect(post('/tic-tac-toe')).to route_to(
      controller: 'mnk_games',
      action: 'create',
      game: { m: 3, n: 3, k: 3 }.stringify_keys
    )
  end

  it 'routes PATCH /tic-tac-toe/:id to mnk_games#update' do
    expect(patch('/tic-tac-toe/1')).to route_to(
      controller: 'mnk_games',
      action: 'update',
      id: '1'
    )
  end
end
