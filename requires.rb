#!/usr/bin/ruby
require 'io/console'
require 'socket'

# Init
# initialize class for the HookService, Functions, and Socket
require_relative 'lib/init.rb'

# Hide
# Useful to hide STDOUT data (password input)
require_relative 'lib/hide.rb'

# Bot < Init
# Handles socket data, server connection, and commands
require_relative 'lib/bot.rb'

# HookService
# Handles hooks and callbacks for bot commands
require_relative 'lib/hookservice.rb'

# Command < HookService
# Handles the creation of bot commands and adding them to the HookService
require_relative 'lib/command.rb'
