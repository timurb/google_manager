require 'google/version.rb'
require 'google/user'
require 'google/group'

# Add requires for other files you add to your project here, so
# you just need to require this one file in your bin file

module Google
  class Connector

    class << self
      def transporter
        @@transporter
      end

      def user(command, args)
        raise "No command specified" if !command || command.empty?
        Google::User.send( command, args )
      end

      def group(command, args)
        raise "No command specified" if !command || command.empty?
        Google::Group.send( command, args )
      end
    end

    def initialize(options)
      @options = options || {}
      transporter
    end

    def domain
      options[:domain]
    end

    def transporter
      if ! defined?(@@transporter)
        @@transporter = GoogleApps::Transport.new(domain)
        @@transporter.authenticate(admin_user,admin_password)
      end
      @@transporter
    end

    private

    def options
      @options
    end

    def admin_user
      options[:user]
    end

    def admin_password
      options[:password]
    end
  end
end
