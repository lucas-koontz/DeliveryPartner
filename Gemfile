# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'activerecord-postgis-adapter', '~> 7.0.1'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'cpf_cnpj', '~> 0.5.0'
gem 'graphql', '~> 1.12.3'
gem 'jbuilder', '~> 2.7'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.1'
gem 'rgeo-geojson', '~> 2.1.1'
gem 'sass-rails', '>= 6'
gem 'shoulda-matchers', '~> 4.5.1'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.1.0'
  gem 'faker', '~> 2.15.1'
  gem 'pry-byebug', '~> 3.9.0'
  gem 'rspec-graphql_matchers', '~> 1.3.0'
  gem 'rspec-rails', '~> 4.0.2'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end

group :development do
  gem 'graphiql-rails'
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
