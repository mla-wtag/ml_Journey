source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'
gem 'bcrypt', '~> 3.1', '>= 3.1.19'
gem 'bootsnap', require: false
gem 'cancancan'
gem 'importmap-rails'
gem 'jbuilder'
gem 'pg'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.7', '>= 7.0.7.2'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[ mingw mswin x64_mingw jruby ]

group :development, :test do
  gem 'debug', platforms: %i[ mri mingw x64_mingw ]
  gem 'factory_bot_rails', '~> 6.2'
  gem 'i18n', '~> 1.14', '>= 1.14.1'
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.5'
  gem 'rufo', '~> 0.16.2'
  gem 'rspec-rails', '~> 6.0.0'
end

group :development do
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
