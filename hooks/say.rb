say = Command.new({
  :priv      => 'all',
  :locked    => false,
  :hook      => ->() {
    string = @bot.get[:socket_data].drop(4).join(' ')
    raw_send("PRIVMSG #{@bot.get[:channel]} :'#{string}'")
  },
  :cb        => '!say',
  :usage     => '!say <string ... 1> <string ... 2> <string ... n>',
  :help      => 'Message current channel with <string ... n> data',
  :bot       => @bot
})
