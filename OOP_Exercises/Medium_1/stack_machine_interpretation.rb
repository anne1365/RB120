class EmptyStackError < StandardError; end
class InvalidTokenError < StandardError; end

class Minilang
  def initialize(command_str)
    @command_str = command_str.split
    @stack = []
    @register = (number?(command_str[0]) ? command_str[0].to_i : 0)
  end

  def eval
    if number?(@command_str[0])
      @register = @command_str[0].to_i 
      @command_str.shift
    end

    @command_str.each_with_index do |command, idx|
      if number?(command)
        @register = command.to_i 
        next
      end

      case command
      when 'PUSH'  then push
      when 'n'     then n(@register.to.i)
      when 'ADD'   then add
      when 'SUB'   then subtract
      when 'MULT'  then mult
      when 'DIV'   then div
      when 'MOD'   then mod
      when 'POP'   then pop
      when 'PRINT' then print_register
      else return raise InvalidTokenError.new("Invalid token: #{command}")
      end
    end

    @register
  end

  private

  def push
    @stack << @register
  end

  def n(value)
    @register = value
  end

  def add
    @register += @stack.pop
  end

  def subtract
    @register -= @stack.pop
  end

  def mult
    @register *= @stack.pop
  end

  def div
    @register /= @stack.pop
  end

  def mod
    @register %= @stack.pop
  end

  def pop
    @register = @stack.pop
  end

  def print_register
    unless !@register.nil?
      return raise EmptyStackError.new("Empty stack!")
    end
    puts @register 
  end

  def number?(command)
    command.to_i.to_s == command
  end
end

Minilang.new('PRINT').eval
# 0
Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15
Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8
Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5
# Minilang.new('5 PUSH POP POP PRINT').eval
# # Empty stack!
Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6
Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12
Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB
Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8
Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)
