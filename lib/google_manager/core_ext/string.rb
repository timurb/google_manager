class String
  def boolean
    case self.downcase
    when "true"
      true
    when "false"
      false
    else
      raise "Unknown boolean value: #{self}"
    end
  end
end
