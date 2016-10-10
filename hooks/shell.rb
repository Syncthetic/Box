shell = Command.new({
  :priv      => 'owner',
  :locked    => false,
  :hook      => ->() {
    string = @bot.get[:socket_data].drop(4).join(' ')
    res = `#{string}`.split("\n")
    res.map { |r| raw_send("PRIVMSG #{@bot.get[:channel]} :#{r}") }
  },
  :cb        => '!shell',
  :usage     => '!shell <cmd>',
  :help      => 'Message current channel with <cmd> shell result',
  :bot       => @bot
})
