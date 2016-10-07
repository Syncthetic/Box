exit = Command.new({
  :priv      => 'owner',
  :locked    => false,
  :cb        => '!join',
  :usage     => '!join <chan list>',
  :help      => 'Sends JOIN for <chan list>',
  :args => true,
  :hook      => ->(chan_list) {
    chan_list.split(',').map { |c| raw_send "JOIN #{c}"}
  },
  :bot => @bot,
})
