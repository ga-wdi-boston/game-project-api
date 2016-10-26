# Inherit from this class to require authenticated access to all actions
class ProtectedController < ApplicationController
  before_action :authenticate
end
