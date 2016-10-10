def raw_send(command)
  if @bot.notification
    print "--> #{command}\r"
    @bot.socket.puts(command)
    print "#{@bot.notification}\r"
  else
    puts "--> #{command}"
    @bot.socket.puts(command)
  end
end
