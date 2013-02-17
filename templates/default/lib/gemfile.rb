run 'rm Gemfile'
create_file 'Gemfile' do
<<-RUBY
source 'http://rubygems.org'

gem "rails", "3.2.11"
gem "pg"

# for sphinx search we also need mysql2
gem "thinking-sphinx"
gem "mysql2"

gem "jquery-rails"
gem "unicorn"
gem "thor"
gem "settingslogic"
gem "coffee-script"
gem "haml-rails"
gem "state_machine"
gem "yajl-ruby"
# gem "newrelic_rpm"
gem "awesome_print"
gem "uglifier"
gem "execjs"
gem "therubyracer"
gem "devise"
gem "omniauth-facebook", "1.4.0"
gem "omniauth-vkontakte"
gem "omniauth-odnoklassniki"
gem "kaminari"
gem "carrierwave"
gem "rmagick"
gem "sanitize"
gem "progressbar"
gem "faraday"
gem "faraday_middleware"
gem "patron"
gem "certified"
gem "unicode"
gem "rolify"
gem "psych"
gem "sentry-raven", :git => "https://github.com/getsentry/raven-ruby.git"
gem "simple_form"

group :assets do
  gem "sass-rails"
  gem "compass-rails"
  gem "turbo-sprockets-rails3", "~> 0.3.6"
  gem "bootstrap-sass", "~> 2.2.1.1"
end

group :development do
  gem "thin"
  gem "mongrel", "1.2.0.pre2"
  gem "mina"
  gem "capistrano"
  gem "capistrano-ext"
  gem "capistrano_colors"
  gem "rvm-capistrano"
  gem "letter_opener"
  gem "annotate"
  gem "faker"
end

group :test, :development do
  gem "rspec-rails"
  gem "factory_girl_rails"
end

RUBY
end

run 'bundle install'