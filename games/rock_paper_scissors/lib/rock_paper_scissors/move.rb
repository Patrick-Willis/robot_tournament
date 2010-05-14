class Move
  class NeedToExecute < StandardError; end
  include Comparable
  
  attr_reader :player
  
  def initialize(player, reporter)
    @player = player
    @reporter = reporter
  end
  
  def <=>(other)
    raise(NeedToExecute) unless @value or @fail_message
    return 0 if other.value == self.value
    case @value
    when "fail"
      return -1
    when "rock"
      return (other.value == "paper")    ? -1 : 1
    when "paper"
      return (other.value == "scissors") ? -1 : 1
    when "scissors"
      return (other.value == "rock")     ? -1 : 1
    end
    raise("don't know how to compare #{other.value} with #{@value}")
  end
  
  def to_s
    @value
  end
  
  def execute
    @player.move(self)
    self
  end
  
  def result(value)
    @value = value
    @reporter.move(@player.name, value)
    self
  end
  
  def fail(message)
    @fail_message = message
    @value = "fail"
    @reporter.fail(@player.name, message)
    self
  end
  
  protected
  attr_reader :value
end

