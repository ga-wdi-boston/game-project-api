# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'routes for gomoku' do
  it 'routes GET /gomoku to mnk_games#index' do
    expect(get('/gomoku')).to route_to(
      controller: 'mnk_games',
      action: 'index'
    )
  end

  it 'routes GET /gomoku/:id to mnk_games#show' do
    expect(get('/gomoku/1')).to route_to(
      controller: 'mnk_games',
      action: 'show',
      id: '1'
    )
  end

  it 'routes GET /gomoku/:id/watch to mnk_games#watch' do
    expect(get('/gomoku/1/watch')).to route_to(
      controller: 'mnk_games',
      action: 'watch',
      id: '1'
    )
  end

  it 'routes POST /gomoku to mnk_games#create' do
    expect(post('/gomoku')).to route_to(
      controller: 'mnk_games',
      action: 'create',
      game: { m: 15, n: 15, k: 5 }.stringify_keys
    )
  end

  it 'routes PATCH /gomoku/:id to mnk_games#update' do
    expect(patch('/gomoku/1')).to route_to(
      controller: 'mnk_games',
      action: 'update',
      id: '1'
    )
  end
end
