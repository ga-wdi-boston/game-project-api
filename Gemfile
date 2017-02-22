# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.3.1'

gem 'active_model_serializers', '~> 0.10.0'
gem 'bcrypt', '~> 3.1.11'
gem 'pg'
gem 'puma', '~> 3.0'
gem 'rack-cors', require: 'rack/cors'
gem 'rails', '~> 5.0.1'

group :development, :test do
  gem 'byebug', '~> 9.0'
  gem 'dotenv-rails', '~> 2.1', '>= 2.1.1'
  gem 'pry', '~> 0.10'
  gem 'pry-byebug', '~> 3.3'
  gem 'rspec-rails', '~> 3.5'
  gem 'rubocop', '~> 0.46'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'pry-rails', '~> 0.3.4'
  gem 'spring', '~> 1.6'
  gem 'spring-commands-rspec', '~> 1.0'
end

group :production do
  gem 'rails_12factor', '~> 0.0.3'
end
