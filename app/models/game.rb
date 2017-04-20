# frozen_string_literal: true

class Game < ApplicationRecord
  include ListenNotify
  include MNKValidation
  include GameOverCheck

  notify_on_update

  before_create :create_cells

  belongs_to :player_x, class_name: 'User'
  belongs_to :player_o, class_name: 'User', optional: true

  validates :player_x, presence: true
  validates :player_o, presence: true, allow_nil: true

  m, n = Rails.application.config.game_settings.values_at(:m, :n)

  validates :m, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: m[:min],
    less_than_or_equal_to: m[:max]
  }
  validates :n, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: n[:min],
    less_than_or_equal_to: n[:max]
  }
  validates :k, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: [m[:min], n[:min]].min,
    less_than_or_equal_to: proc { |game| [game.m, game.n].min }
  }

  private

  def create_cells
    self.cells = Array.new(m * n)
  end
end
