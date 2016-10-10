class HookService
  attr_accessor :cb, :hook
  attr_writer :bot

  def fetch()
    data = @bot.get[:socket_data]
    @bot.command_list.each do |hook|
      begin
        cb = data[3][1..-1]
        if hook.cb == cb
          puts "Calling Hook: #{cb}"

          if hook.type == 'notice'
            raw_send("PRIVMSG #{@bot.get[:channel]} :Sending INFORMATION via NOTICE, #{@bot.get[:host_data][:nickname]}")
            @bot.get[:channel] = @bot.get[:host_data][:nickname]
          end

          if hook.type == 'broadcast'
            raw_send("NOTICE #{@bot.owner} :Sending Broadcast message!")
          end

          if hook.locked == true
            puts "That function is currently locked."
            break
          end

          case hook.priv
          when 'owner'
            # PERFORM AUTHENTICATION CHECK
            if @bot.get[:host_data][:nickname] == @bot.owner
              hook.call_hook
            else
              raw_send("PRIVMSG #{@bot.get[:channel]} :#{@bot.get[:host_data][:nickname]}, you are not my owner...")
            end
          when 'mod'
            # PERFORM AUTHENTICATION CHECK
            #=> if @bot.moderators.include?(called_by)
            hook.call_hook
          when 'all'
            hook.call_hook
          end
          break
        else
        end
      rescue Exception => e
        puts "#{e}"
      end # end begin
    end
  end

end
