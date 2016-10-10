class Command < HookService
  attr_accessor :help, :priv, :usage, :locked, :type
  def initialize(settings)
    settings.each do |key, val|
      self.instance_variable_set('@' + key.to_s, val)
    end
    self.add
  end
  def add
    @bot.command_list.push(self)
  end
  def call_hook
    begin
      self.hook.call
    rescue Exception => e
      puts "#{e}"
    end
  end
end
