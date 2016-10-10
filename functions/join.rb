def join(chan_list)
  chan_list.split(',').map { |c|
    raw_send "JOIN #{c}"
    @bot.get[:joined_channels].push(c)
  }
  puts "[+] CHANNEL LIST UPDATED: #{@bot.get[:joined_channels]}"
end
