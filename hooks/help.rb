help = Command.new({
  :priv      => 'all',
  :locked    => false,
  :hook      => ->() {
    hooks = @bot.command_list
    raw_send("PRIVMSG #{@bot.chans} :Sending Help commands via NOTICE, #{@bot.chan}")
    raw_send("NOTICE #{@bot.chan} :HELP MENU")
    hooks.map { |hook|
      raw_send("NOTICE #{@bot.chan} :#{hook.cb} (#{hook.priv})")
      raw_send("NOTICE #{@bot.chan} :USAGE        : #{hook.usage}")
      raw_send("NOTICE #{@bot.chan} :DESCRIPTION  : #{hook.help}")
      raw_send("NOTICE #{@bot.chan} : ")
    }
  },
  :cb        => '!help',
  :usage     => '!help, !help <cmd> *NOT IMPLEMENTED YET',
  :help      => 'Display this text',
  :args      => false,
  :bot       => @bot,
  :type      => 'notice'
})
