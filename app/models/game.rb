# frozen_string_literal: true
class Game < ApplicationRecord
  include ListenNotify

  notify_on_update

  belongs_to :player_x, class_name: 'User'
  belongs_to :player_o, class_name: 'User', optional: true

  validates :player_x, presence: true
  validates :player_o, presence: true, allow_nil: true

  [:m, :n, :k].each do |attribute|
    validates attribute,
              presence: true,
              numericality: {
                only_integer: true,
                greater_than_or_equal_to: 3
              }
  end

  validates :k, numericality: { less_than_or_equal_to: [:m, :n].min }
end
