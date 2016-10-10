part_chans = Command.new({
  :priv      => 'owner',
  :locked    => false,
  :cb        => '!part',
  :usage     => '!part <chan list>',
  :help      => 'Sends PART for <chan list>',
  :hook      => ->() {
    chan_list = @bot.get[:socket_data].drop(4).join(' ').split(', ')
    raw_send("PRIVMSG #{@bot.get[:channel]} :Parting channels")
    chan_list.each do |chan|
      raw_send("PART #{chan}")
      @bot.get[:joined_channels].delete(chan)
    end
    puts "[+] CHANNEL LIST UPDATED: #{@bot.get[:joined_channels]}"
  },
  :bot => @bot,
})
