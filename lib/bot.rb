
class Bot < Init
  attr_accessor :nick, :owner, :port, :chans,
                :bot_pass, :server_pass, :ssl, :server,
                :command_list, :socket


  def initialize(settings)
    settings.each do |key, val|
      self.instance_variable_set('@' + key.to_s, val)
    end
  end

  def request_password
    @socket.puts "PRIVMSG NickServ :identify #{Hide::stdout}"
    self.notification = false
  end

  def info
    nick     = "| Nick:     | #{@nick}"
    server   = "| Server:   | #{@server}"
    port     = "| Port:     | #{@port}"
    channels = "| Channels: | #{@chans}"
    title    = 'Bot Schema'
    l        = [nick, server, port, channels].map(&:size).max
    _        = ((l - title.size) / 2)

    puts " " * _ + title + " " * _
    bar = "+" + "-" * l + "+"
    puts bar

    [nick,server,port,channels].each do |i|
      diff = l - i.size + 1
      puts i + " " * diff + "|"
    end
    puts "#{bar}\n"
  end

  def start
    initialize_hooks
    initialize_socket
    initialize_functions
    connect
  end

def connect
    hook = HookService.new
    hook.bot = self
    puts "[+] Connecting to: #{@server}"

    identified = false
    if !identified
      sleep(2)
      @socket.puts "raw CAP REQ :twitch.tv/membership" if @server == 'irc.twitch.tv'
      @socket.puts  "USER #{@nick} #{@nick} #{@nick} :#{@nick}"
      @socket.puts  "NICK #{@nick}"
      identified = true
    end

    def data_stdout(data)
      if !@notification
        puts "<-- #{data}"
      else
        print "<-- #{data}\r"
        print "#{self.notification}\r"
      end
    end

    while data = @socket.gets
      data_stdout(data)
      input = data.split(' ')
      @socket.puts "PONG #{input[1]}" if input[0] == 'PING'
      if input[1] == '376'
        @socket.puts "JOIN #{@chans}"
        if @pass
          self.notification = '  <-- Bot Password Request [+]'
          Thread.new { request_password }
        end
      end
      if input[0] == 'ERROR' and input[1] == ':Closing' and input[2] == 'Link:'
        puts "[!] Your host: #{input[3]} has been banned or removed from the server: #{@server}"
        puts "[+] Attempting to Reconnect"
        self.connect
      end
      # Gather some useful host information from calls
      full_user        = input[0]                   #=> array[:Ninjex!bounces@HTS-ED9DAF7A.kphservices.com]
      user_array       = full_user.split('@')       #=> array[:Ninjex!bounces, HTS-ED9DAF7A.kphservices.com]
      user_name_array  = user_array[0].split('!')   #=> array[:Ninjex, bounces]
      user_name_first  = user_name_array[0][1..-1]  #=> array[Ninjex]
      user_name_second = user_name_array[1]         #=> array[bounces]
      user_host        = user_array[1]              #=> array[HTS-ED9DAF7A.kphservices.com]
      hook.fetch(input, user_name_first) if input.size >= 4
    end
  end
end
