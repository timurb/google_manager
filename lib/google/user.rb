module Google
  class User
    class << self
      def list(fields)
        fields = ['login'] if !fields || fields.empty?
        Google::Connector.transporter.get_users.each do |user|
          puts fields.map { |field|
            "#{field}: #{user.send(field).to_s}"
          }.join("\t")
        end
      end
    end
  end
end
