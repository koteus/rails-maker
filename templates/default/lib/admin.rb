say "Building admin"
generate(:controller, "admin/dashboard index")
route("match 'admin' => 'admin/dashboard#index'")

# Do layout and SASS stuff
apply File.expand_path("../admin/sass.rb", __FILE__)
apply File.expand_path("../admin/layout.rb", __FILE__)

create_file 'app/controllers/admin/base_controller.rb' do
<<-RUBY
class Admin::BaseController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!  
  before_filter :verify_admin

private
  def verify_admin
    redirect_to root_url unless current_user.role? :admin
  end
end
RUBY
end

gsub_file 'app/controllers/admin/dashboard_controller.rb', /ApplicationController/, 'Admin::BaseController'

# make a user admin
apply File.expand_path("../admin/users.rb", __FILE__)
apply File.expand_path("../admin/dashboard_spec.rb", __FILE__)
apply File.expand_path("../admin/users_spec.rb", __FILE__)
