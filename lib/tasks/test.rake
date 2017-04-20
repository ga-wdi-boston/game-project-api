# frozen_string_literal: true

unless Rails.env.production?
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:test)
end
