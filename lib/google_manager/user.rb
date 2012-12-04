require 'google_manager/base_resource'
require 'google_manager/nickname'
#require 'google_apps/atom/document'

module GoogleManager
  class User < BaseResource
    class << self

      def get( args )
        user = unprocessed_get(args)
        username = user.username
        nicknames = GoogleManager::Connector.command(:nickname, :unprocessed_get, [username])
        if nicknames.empty?
          format_output(user)
        else
          format_output(user) + nicknames.to_a[0][1].join(", ")
        end
      end

      def suspend( args )
        result = GoogleManager::Connector.transporter.suspend_user(args[0])
        format_output(result)
      end

      def unsuspend( args )
        result = GoogleManager::Connector.transporter.restore_user(args[0])
        format_output(result)
      end

      alias :delete :suspend

      def create( *args )
        raise "'Create' is not implemented for users"
      end


      def format_get_output( args )
        raise "You should not reach here"
      end

      def format_output( entry )
        "#{toggle_char(entry.admin,"admin")}:#{toggle_char(entry.suspended,"suspended")}:#{toggle_char(entry.change_password_at_next_login,"reset")}:#{toggle_char(entry.agreed_to_terms,"inactive", :not)}:#{entry.username}:"
      end

      def resource_name
        "user"
      end

    end
  end
end
