reload_hooks = Command.new({
  :priv      => 'owner',
  :locked    => false,
  :cb        => '!refresh',
  :usage     => '!refresh',
  :help      => 'Updates all hooks',
  :args => false,
  :hook      => ->() {
    raw_send("PRIVMSG #{@bot.chans} :Refreshing hooks!")
    @bot.command_list = []
    @bot.initialize_hooks
    @bot.initialize_functions
  },
  :bot => @bot,
})
