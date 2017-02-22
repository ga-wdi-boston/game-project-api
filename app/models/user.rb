# frozen_string_literal: true
class User < ActiveRecord::Base
  include Authentication
  has_many :games
end
