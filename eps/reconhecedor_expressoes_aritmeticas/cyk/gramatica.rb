class Regra
  attr_reader :esquerda, :direita

  def initialize(esquerda, direita)
    @esquerda = esquerda
    @direita = direita
  end

  def to_s
    @esquerda + '->' + @direita.join
  end
end

class Gramatica
  attr_reader :regras, :simbolo_inicial

  def initialize(simbolo_inicial)
    @simbolo_inicial = simbolo_inicial
    @regras = []
  end

  def adiciona_regra(regra)
    @regras << regra
  end

  def to_s
    @regras.map(&:to_s).join("\n")
  end
end
