source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '3.2.13'
gem 'bootstrap-sass'


gem 'mongoid', '~> 3.0'
gem 'mongoid-history', '~> 0.3.3'
gem 'newrelic_rpm'
gem 'stripe', :git => 'https://github.com/stripe/stripe-ruby'
gem 'paypal-express'

#admin
gem 'rails_admin'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

group :production do
  gem 'thin'
end

group :development, :test do
    gem 'foreman'
    gem 'rspec'
    gem 'rspec-rails'
    gem 'guard'
    gem 'terminal-notifier-guard'
    gem 'guard-rspec'
    gem 'capybara'
    #gem 'capybara-webkit', :git => 'https://github.com/thoughtbot/capybara-webkit.git'
    gem 'selenium-webdriver'
    gem 'launchy'
    gem 'factory_girl_rails'
    gem 'faker'
    gem 'debugger'
end

group :test do
    gem 'webmock'
    gem 'capybara-screenshot'
end

gem "devise"
