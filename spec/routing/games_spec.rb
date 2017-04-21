# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'routes for games' do
  it 'routes GET /games to mnk_games#index' do
    expect(get('/games')).to route_to(
      controller: 'mnk_games',
      action: 'index'
    )
  end

  it 'routes GET /games/:id to mnk_games#show' do
    expect(get('/games/1')).to route_to(
      controller: 'mnk_games',
      action: 'show',
      id: '1'
    )
  end

  it 'routes GET /games/:id/watch to mnk_games#watch' do
    expect(get('/games/1/watch')).to route_to(
      controller: 'mnk_games',
      action: 'watch',
      id: '1'
    )
  end

  it 'routes POST /games to mnk_games#create' do
    expect(post('/games')).to route_to(
      controller: 'mnk_games',
      action: 'create',
      game: { m: 3, n: 3, k: 3 }.stringify_keys
    )
  end

  it 'routes PATCH /games/:id to mnk_games#update' do
    expect(patch('/games/1')).to route_to(
      controller: 'mnk_games',
      action: 'update',
      id: '1'
    )
  end
end
