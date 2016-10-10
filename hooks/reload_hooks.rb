reload_hooks = Command.new({
  :priv      => 'owner',
  :locked    => false,
  :cb        => '!refresh',
  :usage     => '!refresh',
  :help      => 'Updates all hooks',
  :type      => 'broadcast',
  :hook      => ->() {
    chan_list = @bot.get[:joined_channels]
    chan_list.map { |chan| raw_send "PRIVMSG #{chan} :Refreshing hooks!"}
    @bot.command_list = []
    @bot.initialize_hooks
    @bot.initialize_functions
  },
  :bot => @bot,
})
