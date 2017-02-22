# frozen_string_literal: true
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)
ENV['PORT'] ||= 'GA'.each_byte.reduce('') { |a, e| a + format('%x', e) }

require 'bundler/setup' # Set up gems listed in the Gemfile.
