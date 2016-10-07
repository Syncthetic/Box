say = Command.new({
  :priv      => 'all',
  :locked    => false,
  :hook      => ->(string) {
    raw_send("PRIVMSG #{@bot.chans} :#{string}")
    #puts "PRIVMSG #{@bot.chans} :#{string}"
  },
  :cb        => '!say',
  :usage     => '!say <string ... 1> <string ... 2> <string ... n>',
  :help      => 'Message current channel with <string ... n> data',
  :args      => true, # Can we pass it here?
  :bot       => @bot
})
