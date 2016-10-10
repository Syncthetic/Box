def host_data(host)
  begin
nickname  = host.scan(/[A-z].*!/)
username  = host.scan(/!(.*)@/)
hostname  = host.scan(/@.*/)
if [nickname, username, hostname].map(&:size).inject(:+) >= 3
    return {
      :nickname  => nickname[0][0..-2],
      :username  => username[0][0],
      :hostname  => hostname[0][1..-1]
    }
end
  rescue => e
    puts "Error Calling host_data(#{host})"
    puts "#{e}"
  end
end
