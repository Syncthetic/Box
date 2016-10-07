class HookService
  attr_accessor :cb, :hook
  attr_writer :bot

  def fetch(data, user)
    @bot.command_list.each do |hook|
      begin
        cb = data[3][1..-1]
        if hook.cb == cb
          puts "Calling Hook: #{cb}"
          @bot.chan = user if hook.type == 'notice'
          if hook.args != false
            hook.args = data.drop(4).join(' ')
          end

          if hook.locked == true
            puts "That function is currently locked."
            break
          end

          case hook.priv
          when 'owner'
            # PERFORM AUTHENTICATION CHECK
            if user == @bot.owner
              hook.call_hook
            else
              raw_send("PRIVMSG #{@bot.chans} :#{user}, you are not my owner...")
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
