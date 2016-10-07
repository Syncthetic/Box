def raw_send(command)
  puts "--> #{command}"
  @bot.socket.puts(command)
end
