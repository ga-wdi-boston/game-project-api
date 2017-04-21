# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'routes for mnk_games' do
  it 'routes GET /mnk-games to mnk_games#index' do
    expect(get('/mnk-games')).to route_to(
      controller: 'mnk_games',
      action: 'index'
    )
  end

  it 'routes GET /mnk-games/:id to mnk_games#show' do
    expect(get('/mnk-games/1')).to route_to(
      controller: 'mnk_games',
      action: 'show',
      id: '1'
    )
  end

  it 'routes GET /mnk-games/:id/watch to mnk_games#watch' do
    expect(get('/mnk-games/1/watch')).to route_to(
      controller: 'mnk_games',
      action: 'watch',
      id: '1'
    )
  end

  it 'routes POST /mnk-games to mnk_games#create' do
    expect(post('/mnk-games')).to route_to(
      controller: 'mnk_games',
      action: 'create'
    )
  end

  it 'routes PATCH /mnk-games/:id to mnk_games#update' do
    expect(patch('/mnk-games/1')).to route_to(
      controller: 'mnk_games',
      action: 'update',
      id: '1'
    )
  end
end
