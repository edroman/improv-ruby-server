source 'http://rubygems.org'

#gem 'rails', '3.1.3'
gem 'rails', '3.2.1'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

group :development do
  gem 'rails-dev-tweaks'    # for ActiveAdmin in dev mode to not cause app to be slow
  gem 'sqlite3'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
#  gem 'sass-rails',   '~> 3.1.5'
#  gem 'coffee-rails', '~> 3.1.1'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier', '>= 1.0.3'
end

# PostgresSQL
gem 'pg'

# Omniauth
gem 'omniauth-facebook'
gem 'omniauth-twitter'

# HAML support
gem 'haml'
# Forces code generators to also use HAML
gem 'haml-rails'

#  gem 'jquery-rails'
  gem 'jquery-rails', '~> 2.0.0'

# These lines are required for ActiveAdmin panel
gem "formtastic", "~> 2.1.1"
#gem "devise", "~> 1.4.7"          # necessary due to heroku migration issues
gem "activeadmin", "~> 0.4.3"

#gem 'sass-rails'
gem 'sass-rails',   '~> 3.2.3'

gem 'meta_search', '>= 1.1.0.pre'


# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', '0.8.2', :require => false
end
