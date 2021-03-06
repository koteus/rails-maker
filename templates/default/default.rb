module RailsMaker

  module Templates

    class Default < RailsMaker::TemplateRunner

      # Class Options
      # @see https://github.com/wycats/thor/wiki/Groups
      class_option :auth  , :type => :boolean , :default => true , :banner => "Sets up devise for authentication."
      class_option :roles , :type => :boolean , :default => true , :banner => "Sets up cancan for authorization with rolify."
      class_option :admin , :type => :boolean , :default => true , :banner => "Sets up very basic admin"

      # Descriptions
      desc "Runs the default rails-maker Rails stack task"

      # The method to run when the template is invoked
      def on_invocation  

        # Dup our options so we can modify them
        opts = options.dup

        # Can't build an admin or roles without devise
        unless opts[:auth]
          opts[:admin] = false
          opts[:roles] = false
        end

        # Env vars used in our template
        ENV['RAILSMAKER_AUTH']  = "true" if opts[:auth]
        ENV['RAILSMAKER_ADMIN'] = "true" if opts[:admin]
        ENV['RAILSMAKER_ROLES'] = "true" if opts[:roles]
        ENV['RAILSMAKER_USER_NAME'] = git_user_name if opts[:admin]
        ENV['RAILSMAKER_USER_EMAIL'] = git_user_email if opts[:admin]
        ENV['RAILSMAKER_USER_PASSWORD'] = user_password if opts[:admin]

      end

      private

      def git_user_name
        `git config --global user.name`.chomp.gsub('"', '\"') || 'admin'
      end

      def git_user_email
        `git config --global user.email`.chomp || 'admin@ikitlab.com'
      end

      def user_password
        'admin123'
      end

    end

  end

end

