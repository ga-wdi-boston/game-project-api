# frozen_string_literal: true

namespace :db do
  desc 'Load example data from db/examples.rb'
  task examples: :environment do
    require_relative '../../db/examples'
  end

  unless Rails.env == 'production'
    desc 'Drop and setup the development database with examples'
    task nuke_pave:
      %w[environment db:drop db:create db:migrate db:seed db:examples] do
      puts "Nuke and pave of #{Rails.env} complete."
    end
  end
end
