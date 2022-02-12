source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'rails', '6.0.3'
gem 'mysql2', '0.5.3'
gem 'puma', '~> 4.3'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'rack-cors', '1.1.1'

group :development, :test do
  gem 'pry', '0.13.1'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring', '2.1.0'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'rspec-rails', '~> 4.0.0'
  gem 'factory_bot_rails', '5.2.0'
  gem 'database_cleaner-active_record', '1.8.0'
  gem 'fork_break', '0.1.4'
end
