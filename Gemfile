source 'https://rubygems.org'

gem 'rails', '3.2.21'

gem 'pg'
gem 'haml'
gem 'nokogiri'
gem 'unicode'
gem 'google-webfonts'
gem 'jquery-rails'
gem 'whenever', :require => false
gem 'slack-post'

# Deploy with Capistrano
gem 'capistrano'
gem 'rvm-capistrano'

group :development, :test do
  gem 'thin'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'launchy'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'hirb'
end

group :test do
  gem 'cucumber-rails', :require => false
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git', :branch => 'bootstrap3'
end
