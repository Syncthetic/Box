exit = Command.new({
  :priv      => 'owner',
  :locked    => false,
  :cb        => '!exit',
  :usage     => '!exit',
  :help      => 'Sends QUIT message',
  :hook      => ->() {
    raw_send "QUIT Ninjex made me do it..."
  },
  :bot => @bot,
})
