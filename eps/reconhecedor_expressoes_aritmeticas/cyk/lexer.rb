class Token
  attr_reader :type, :value

  def initialize(type, value)
    @type = type
    @value = value
  end

  def to_s
    "#{type}(#{value})"
  end
end

class Lexer
  def initialize(input)
    @input = input
    @position = 0
  end

  def tokenize
    tokens = []
    while current_char
      case current_char
      when /\s/
        advance
      when /\d/
        tokens << number
      when '+'
        tokens << Token.new(:PLUS, '+')
        advance
      when '*'
        tokens << Token.new(:MUL, '*')
        advance
      else
        raise "Unexpected character: #{current_char}"
      end
    end
    tokens
  end

  private

  def current_char
    @input[@position]
  end

  def advance
    @position += 1
  end

  def number
    start = @position
    advance while current_char =~ /\d/
    Token.new(:NUMBER, @input[start...@position].to_i)
  end
end