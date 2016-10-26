ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' # Set up gems listed in the Gemfile.

# added to change default development port
require 'rails/commands/server'

module DefaultOptions
  DEV_PORT = 'GA'.each_byte.reduce('') { |a, e| a + format('%x', e) }.to_i
  def default_options
    super.merge(Port: DEV_PORT)
  end
end

Rails::Server.send(:prepend, DefaultOptions)
