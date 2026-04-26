require_relative "cyk"
require_relative "gramatica"
require_relative "arvore"

gramatica = Gramatica.new("E")

# Terminais de operadores
gramatica.adiciona_regra(Regra.new('T_MAIS',   ['+']))
gramatica.adiciona_regra(Regra.new('T_MENOS',  ['-']))
gramatica.adiciona_regra(Regra.new('T_VEZES',  ['*']))
gramatica.adiciona_regra(Regra.new('T_DIV',    ['/']))
gramatica.adiciona_regra(Regra.new('T_CHAPEU', ['^']))
gramatica.adiciona_regra(Regra.new('T_EPAR',   ['(']))
gramatica.adiciona_regra(Regra.new('T_DPAR',   [')']))

# Terminais de dígitos
gramatica.adiciona_regra(Regra.new('T_0', ['0']))
gramatica.adiciona_regra(Regra.new('T_1', ['1']))
gramatica.adiciona_regra(Regra.new('T_2', ['2']))
gramatica.adiciona_regra(Regra.new('T_3', ['3']))
gramatica.adiciona_regra(Regra.new('T_4', ['4']))
gramatica.adiciona_regra(Regra.new('T_5', ['5']))
gramatica.adiciona_regra(Regra.new('T_6', ['6']))
gramatica.adiciona_regra(Regra.new('T_7', ['7']))
gramatica.adiciona_regra(Regra.new('T_8', ['8']))
gramatica.adiciona_regra(Regra.new('T_9', ['9']))

# Número
%w[T_0 T_1 T_2 T_3 T_4 T_5 T_6 T_7 T_8 T_9].each do |d|
  gramatica.adiciona_regra(Regra.new('NUM',      [d]))
  gramatica.adiciona_regra(Regra.new('DIGITO_NT',[d]))
end
gramatica.adiciona_regra(Regra.new('NUM', %w[NUM DIGITO_NT]))

# Fator
gramatica.adiciona_regra(Regra.new('F',      %w[NUM]))
gramatica.adiciona_regra(Regra.new('F',      %w[T_EPAR PAREN_D]))
gramatica.adiciona_regra(Regra.new('PAREN_D',%w[E T_DPAR]))

# Unário
gramatica.adiciona_regra(Regra.new('U', %w[F]))
gramatica.adiciona_regra(Regra.new('U', %w[T_MENOS U]))

# Potência
gramatica.adiciona_regra(Regra.new('P',     %w[U]))
gramatica.adiciona_regra(Regra.new('P',     %w[U POW_R]))
gramatica.adiciona_regra(Regra.new('POW_R', %w[T_CHAPEU P]))

# Multiplicação e divisão
gramatica.adiciona_regra(Regra.new('T',     %w[P]))
gramatica.adiciona_regra(Regra.new('T',     %w[T MUL_R]))
gramatica.adiciona_regra(Regra.new('MUL_R', %w[T_VEZES P]))
gramatica.adiciona_regra(Regra.new('T',     %w[T DIV_R]))
gramatica.adiciona_regra(Regra.new('DIV_R', %w[T_DIV P]))

# Soma e subtração
gramatica.adiciona_regra(Regra.new('E',     %w[T]))
gramatica.adiciona_regra(Regra.new('E',     %w[E ADD_R]))
gramatica.adiciona_regra(Regra.new('ADD_R', %w[T_MAIS T]))
gramatica.adiciona_regra(Regra.new('E',     %w[E SUB_R]))
gramatica.adiciona_regra(Regra.new('SUB_R', %w[T_MENOS T]))

parser = CYKParser.new(gramatica)

# Testes
entradas = [
  "4+5*2",
  "9^(1*-2+3)-3/(6+3)",
  "56",
  "-1",
  "(3)",
  "6^2",
  "3-1",
  "8/4",
  "1++2",   # inválido
  "(1+2",   # inválido
]

entradas.each do |input|
  parser.parse(input)
  if parser.aceito?
    arvore = Arvore.new(input).parse
    puts "#{input} => #{arvore}"
  else
    puts "#{input} => Rejeitado"
  end
  puts
end