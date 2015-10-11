source 'https://rubygems.org'
ruby '2.2.4'

# Use rails as an api
gem 'rails', '4.2.5.1'
gem 'rails-api'

# Use postgresql as the database for Active Record
gem 'pg'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.10'

# Use Puma as the app server
gem 'puma'

# Cross origin resource sharing
gem 'rack-cors', require: 'rack/cors'

# Serializers
gem 'active_model_serializers'

group :production do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'byebug'
  gem 'pry-rails'
  gem 'rb-readline'
end
