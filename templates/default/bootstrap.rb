require "net/http"
require "net/https"
require "uri"
require 'rbconfig'

say "Building Application with the rails-maker..."

def get_remote_https_file(source, destination)
  uri = URI.parse(source)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
  path = File.join(destination_root, destination)
  File.open(path, "w") { |file| file.write(response.body) }
end

git :init

run 'rm .gitignore'
create_file '.gitignore' do
<<-FILE
.bundle
.DS_Store
log/*.log
tmp/**/*
config/database.yml
db/*.sqlite3
public/system/**/**/**/*
.idea/*
.sass-cache/**/*
*.swp
public/uploads
FILE
end

files = %w{
  gemfile
  haml_generator
  rails_clean
  application_layout
  home_controller
  css
  test_suite
  authentication
  authorization
  admin
  db
  db_seed
}

files.each do |file|
  apply File.expand_path("../lib/#{file}.rb", __FILE__)
end

login_msg = (ENV['RAILSMAKER_ADMIN']) ? "Login to admin with email #{ENV['RAILSMAKER_USER_EMAIL']} and password #{ENV['RAILSMAKER_USER_PASSWORD']}" : ""

say <<-D


  ########################################################################

  The rails-maker just added like 6 hours to your life.

  Template Installed :: Default

  Next run...

  rake spec
  rails s

  #{login_msg}

  ########################################################################
D