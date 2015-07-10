source 'https://rubygems.org'
ruby '2.2.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'
# Use postgresql as the database for Active Record
gem 'pg'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

gem 'puma'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'rack-cors', require: 'rack/cors'

gem 'active_model_serializers'

group :production do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'capistrano', '~> 3.1.0'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-rails', '~> 1.1.1'
  gem 'capistrano-chruby', '~> 0.1.2'

  # Call 'byebug' anywhere to stop execution and get a debugger console
  gem 'byebug'

  gem 'pry-rails'

  gem 'rb-readline'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end
