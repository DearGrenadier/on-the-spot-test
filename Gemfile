source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'rails', '6.0.3'
gem 'mysql2', '0.5.3'
gem 'puma', '~> 4.1'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'rack-cors'

group :development, :test do
  gem 'pry'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'rspec-rails', '~> 4.0.0'
  gem 'factory_bot_rails'
  gem 'database_cleaner-active_record'
end
