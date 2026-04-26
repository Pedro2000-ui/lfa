class Arvore
  def initialize(input)
    @tokens = input.chars
    @pos = 0
  end

  def parse
    resultado = parse_e
    resultado
  end

  private

  def current
    @tokens[@pos]
  end

  def consume(char = nil)
    token = @tokens[@pos]
    @pos += 1
    token
  end

  # E -> E '+' T | E '-' T | T
  def parse_e
    left = parse_t
    while current == '+' || current == '-'
      op = consume
      right = parse_t
      nome = op == '+' ? 'soma' : 'subtracao'
      left = [nome, left, right]
    end
    left
  end

  # T -> T '*' P | T '/' P | P
  def parse_t
    left = parse_p
    while current == '*' || current == '/'
      op = consume
      right = parse_p
      nome = op == '*' ? 'multiplicacao' : 'divisao'
      left = [nome, left, right]
    end
    left
  end

  # P -> U '^' P | U  (associativa à direita)
  def parse_p
    left = parse_u
    if current == '^'
      consume
      right = parse_p
      left = ['potencia', left, right]
    end
    left
  end

  # U -> '-' U | F
  def parse_u
    if current == '-'
      consume
      operando = parse_u
      ['negacao', operando]
    else
      parse_f
    end
  end

  # F -> '(' E ')' | N
  def parse_f
    if current == '('
      consume # '('
      resultado = parse_e
      consume # ')'
      ['parenteses', resultado]
    else
      parse_n
    end
  end

  # N -> sequência de dígitos
  def parse_n
    numero = ''
    while current && current =~ /[0-9]/
      numero += consume
    end
    numero.to_i
  end
end