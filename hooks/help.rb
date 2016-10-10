help = Command.new({
  :priv      => 'all',
  :locked    => false,
  :hook      => ->() {
    hooks = @bot.command_list
    raw_send("NOTICE #{@bot.get[:host_data][:nickname]} :HELP MENU")
    hooks.map { |hook|
      raw_send("NOTICE #{@bot.get[:host_data][:nickname]} :#{hook.cb} (#{hook.priv})")
      raw_send("NOTICE #{@bot.get[:host_data][:nickname]} :USAGE        : #{hook.usage}")
      raw_send("NOTICE #{@bot.get[:host_data][:nickname]} :DESCRIPTION  : #{hook.help}")
      raw_send("NOTICE #{@bot.get[:host_data][:nickname]} : ")
    }
  },
  :cb        => '!help',
  :usage     => '!help, !help <cmd> *NOT IMPLEMENTED YET',
  :help      => 'Display this text',
  :bot       => @bot,
  :type      => 'notice'
})
