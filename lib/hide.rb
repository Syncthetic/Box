class Hide
  def self.stdout
    return STDIN.noecho(&:gets).chomp
  end
end
