#
class Game < ActiveRecord::Base
  include ListenNotify

  notify_on_update

  belongs_to :player_x, class_name: 'User'
  belongs_to :player_o, class_name: 'User'

  validates :player_x, presence: true
  validates :player_o, presence: true, allow_nil: true
end
