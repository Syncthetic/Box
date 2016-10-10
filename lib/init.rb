class Init
  BASE      = File.dirname(__FILE__) + '/../'
  HOOKS     = BASE + 'hooks/'
  FUNCTIONS = BASE + 'functions/'

  def initialize_hooks
    puts ""
    puts "*** INITIALIZING HOOKS ***"
    Dir.foreach(HOOKS) do |file|
      if file.include?('.rb')
        puts "[+] Initializing Hook: #{file[0..-4]}"
        load HOOKS + file
      end
    end
  end

  def initialize_functions
    puts ""
    puts "*** INITIALIZING FUNCTIONS ***"
    Dir.foreach(FUNCTIONS) do |file|
      if file.include?('.rb')
        puts "[+] Loading Function: #{file[0..-4]}"
        load FUNCTIONS + file
      end
    end
  end

  def initialize_socket
    puts ""
    puts "*** INITIALIZING SOCKET ***"
    socket = TCPSocket.new(@server, @port)
    if @ssl
      require 'openssl'
      ssl = OpenSSL::SSL::SSLContext.new
      ssl.verify_mode = OpenSSL::SSL::VERIFY_NONE
      @socket = OpenSSL::SSL::SSLSocket.new(socket, ssl)
      @socket.sync = true
      @socket.connect
    else
      @socket = socket
    end
  end
end
