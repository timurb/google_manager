require 'google_manager/base_resource'

module GoogleManager
  class Group < BaseResource
    class << self

      def unprocessed_get( group )
        api.retrieve_all_members(group).map(&:member_id)
      end

      def get( group )
        members = unprocessed_get(group)
        "#{group}: #{members.join(", ")}"
      end

      def modify( group, members )
        members = process_members(members)

        members.each do |member|
          raise "'#{member}' does not match the accepted form of user@domain.org" unless member =~ /.*@.*\..*/
        end

        add(group, members)
        current_members = unprocessed_get(group)
        remove( group, current_members - members)
      end

      def add( group, members )
        members = process_members(members)
        members.each do |member|
          api.add_member_to_group(member, group)
        end
      end

      def remove( group, members )
        members = process_members(members)
        members.each do |member|
          api.remove_member_from_group(member, group)
        end
      end

      def create(name)
        result = api.create_group(name, [name, "",  "Anyone"])
        format_create_output( result )
      end

      def format_list_output( entry )
        entry.group_id
      end

      def resource_name
        "group"
      end

      private

      def process_members(members)
        if members.is_a?(String)
          members.split(",").map(&:strip)
        else
          members
        end
      end
    end
  end
end
