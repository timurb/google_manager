module GoogleManager
  class Connector

    class << self
      def transporter
        @@transporter
      end

      def command(type, command, *args)
        raise "No command specified" if !command || command.empty?
        "GoogleManager::#{type.to_s.classify}".constantize.send( command, *args )
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
        @@transporter = GAppsProvisioning::ProvisioningApi.new(admin_user, admin_password)
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
