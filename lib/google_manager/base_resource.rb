require 'active_support/core_ext/string/inflections'
require 'google_manager/core_ext/string'

module GoogleManager
  class BaseResource

    class << self
      def list( fields=nil )
        GoogleManager::Connector.transporter.send("retrieve_all_#{resource_name_plural}").map { |entry|
          format_list_output( entry )
        }
      end

      def unprocessed_get( args )
        GoogleManager::Connector.transporter.send("retrieve_#{resource_name}", args[0])
      end

      def get( args )
        format_get_output( unprocessed_get(args) )
      end

      def create( args )
        result = GoogleManager::Connector.transporter.send("create_#{resource_name}", *args)
        format_create_output( result )
      end

      def delete( args )
        result = GoogleManager::Connector.transporter.send("delete_#{resource_name}", args[0])
        result.map { |entry|
          format_output( entry )
        }
      end


      def format_list_output(*args)
        format_output(*args)
      end

      def format_get_output(*args)
        format_output(*args)
      end

      def format_create_output(*args)
        format_output(*args)
      end

      def format_output( entry )
        entry.inspect
      end

      def resource_name
        ""
      end

      def resource_name_plural
        resource_name.pluralize
      end

      def toggle_char(boolean_string, char, inverse = false)
        boolean_string.boolean ^ !!inverse ? char : (" " * char.length)
      end
    end
  end
end
