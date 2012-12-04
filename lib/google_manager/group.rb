require 'google_manager/base_resource'

module GoogleManager
  class Group < BaseResource
    class << self

      def unprocessed_get( args )
        GoogleManager::Connector.transporter.retrieve_all_members(args[0]).map(&:member_id)
      end

      def get( args )
        group = args[0]
        members = unprocessed_get(args)
        "#{group}: #{members.join(", ")}"
      end

      def format_list_output( entry )
        entry.group_id
      end

      def resource_name
        "group"
      end
    end
  end
end
