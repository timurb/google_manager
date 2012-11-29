module Google
  class Group
    class << self
      def list(fields)
        fields = ['id'] if !fields || fields.empty?
        Google::Connector.transporter.get_groups.each do |group|
          puts fields.map { |field|
            "#{field}: #{group.send(field).to_s}"
          }.join("\t")
        end
      end
    end
  end
end
