join_chans = Command.new({
  :priv      => 'owner',
  :locked    => false,
  :cb        => '!join',
  :usage     => '!join <chan list>',
  :help      => 'Sends JOIN for <chan list>',
  :hook      => ->() {
    chan_list = @bot.get[:socket_data].drop(4).join(' ')
    raw_send("PRIVMSG #{@bot.get[:channel]} :Joining channels")
    join(chan_list)
  },
  :bot => @bot,
})
