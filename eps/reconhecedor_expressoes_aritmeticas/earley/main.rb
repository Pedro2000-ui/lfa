require_relative "earley"
require_relative "gramatica"
require_relative "arvore"

regras = [
  # soma/subtração
  Regra.new('E', %w[E + T]),
  Regra.new('E', %w[E - T]),
  Regra.new('E', %w[T]),

  # multiplicação/divisão
  Regra.new('T', %w[T * P]),
  Regra.new('T', %w[T / P]),
  Regra.new('T', %w[P]),

  # Potenciação
  Regra.new('P', %w[U ^ P]),
  Regra.new('P', %w[U]),

  # Unário
  Regra.new('U', %w[- U]),
  Regra.new('U', %w[F]),

  # Fator
  Regra.new('F', %w[( E )]),
  Regra.new('F', %w[N]),

  # sequência de dígitos
  Regra.new('N', %w[N D]),
  Regra.new('N', %w[D]),

  # Dígitos
  Regra.new('D', %w[0]),
  Regra.new('D', %w[1]),
  Regra.new('D', %w[2]),
  Regra.new('D', %w[3]),
  Regra.new('D', %w[4]),
  Regra.new('D', %w[5]),
  Regra.new('D', %w[6]),
  Regra.new('D', %w[7]),
  Regra.new('D', %w[8]),
  Regra.new('D', %w[9]),
]

gramatica = Gramatica.new(regras, 'E')
parser = EarleyParser.new(gramatica)

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
  if parser.parse(input)
    arvore = Arvore.new(input).parse
    puts "#{input} => #{arvore}"
  else
    puts "#{input} => Rejeitado"
  end
  puts
end