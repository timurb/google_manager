require 'google_manager/base_resource'

module GoogleManager
  class Nickname < BaseResource
    class << self

      def list( fields=nil )
        GoogleManager::Connector.transporter.retrieve_all_nicknames.each { |nickname|
          process_nickname(nickname)
        }
        format_list_output( nicknames )
      end

      def unprocessed_get( args )
        user=args[0]
        GoogleManager::Connector.transporter.retrieve_nicknames(user).each { |nickname|
          process_nickname(nickname)
        }
        nicknames
      end

      def format_create_output( result )
        process_nickname(result)
        format_output( nicknames )
      end

      def format_output( nicknames )
        nicknames.map { |k,v|
          "#{k}: #{v.join(", ")}"
        }
      end

      def process_nickname(entry)
        nicknames[entry.login] ||= []
        nicknames[entry.login] << entry.nickname
        nicknames[entry.login].uniq!
        nicknames[entry.login]
      end

      def nicknames
        @nicknames ||= {}
      end

      def resource_name
        "nickname"
      end
    end
  end
end
