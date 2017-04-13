# frozen_string_literal: true
class Game < ApplicationRecord
  include ListenNotify
  include TicTacToeValidation

  notify_on_update

  before_create :create_cells

  belongs_to :player_x, class_name: 'User'
  belongs_to :player_o, class_name: 'User', optional: true

  validates :player_x, presence: true
  validates :player_o, presence: true, allow_nil: true

  [:m, :n].each do |attr|
    validates attr, presence: true, numericality: {
      only_integer: true,
      greater_than_or_equal_to: 3,
      less_than_or_equal_to: 20
    }
  end

  validates :k, numericality: {
    only_integer: true,
    less_than_or_equal_to: [:m, :n].min
  }

  def create_cells
    self.cells = Array.new(m * n)
  end
  private :create_cells
end
