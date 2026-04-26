require 'set'
require 'pastel'
require_relative 'gramatica'
require_relative 'estado'

class EarleyParser
  attr_reader :gramatica, :pastel, :imprimir_regras_producao
  
  def initialize(gramatica)
    @imprimir_regras_producao = imprimir_regras_producao = false
    @pastel = Pastel.new
    
    @gramatica = gramatica
    # Parser de Early precisa de um uma regra S->S
    # para o primeiro passo, assim, adicionamos 
    # automaticamente na gramática
    @gramatica.regras.unshift(Regra.new(gramatica.simbolo_inicial, [gramatica.simbolo_inicial]))
  end

  def parse(entrada)
    # Lista de estado. Tem tamanho do entrada + 1
    # pq se o último tiver o estado inicial,
    # estará no entrada + 1
    @tabela = Array.new(entrada.length + 1) { |indice| S.new(indice, entrada) }

    predict(Estado.new(@gramatica.regras[0], 0, 0, "Regra inicial"), 0)

    if (imprimir_regras_producao)
      puts "\nLendo os caracteres... \n\n"
    end
    #entrada.split('').each_with_index do |item, index|
    (0..entrada.size).each do |index|
      
      if (imprimir_regras_producao)
        if (index == entrada.size)
          puts pastel.red("\n================ Posição: #{index} ================")
        else
          puts pastel.red("\n==== Caracter: #{entrada[index]}, Posição: #{index} ========")
        end
      end
      until @tabela[index].empty?
        estado = @tabela[index].take!
        if estado.completo?
          complete(estado, index)
        else
          # checa se próximo item é um terminal
          if estado.next_symbol == entrada[index] 
            scan(estado, index)
          else
            predict(estado, index)
          end
        end
      end
    end

    if (imprimir_regras_producao)
      puts pastel.red("\n================ Fim de predição ================\n")
      puts pastel.magenta(@tabela)
    end
    final_is_valid?(@tabela[entrada.length])
  end

  private

  def final_is_valid?(estado)
    estado.estados.select { |estado| estado.regra.esquerda == gramatica.simbolo_inicial && estado.completo? && estado.inicio == 0 }.any?
  end

  def predict(estado, index)
    @gramatica.regras.each do |regra|
      if regra.esquerda == estado.next_symbol
        novo_estado = Estado.new(regra, 0, index, "Predito de #{estado}")
        @tabela[index] << novo_estado
        if (imprimir_regras_producao)
          puts pastel.green("[Predict] Adicionando regra #{novo_estado} de Esquerda: #{regra.esquerda} e próximo símbolo: #{estado.next_symbol}")
        end
      end
    end
  end

  def scan(estado, index)
    prox_estado = estado.advance(index, estado)
    if (imprimir_regras_producao)
      puts pastel.yellow "[Scan] Proximo estado: #{prox_estado} em S(#{index+1})"
    end
    @tabela[index + 1] << prox_estado
  end

  def complete(estado, index)
    @tabela[estado.inicio].estados.each do |estado_candidato|
      if estado_candidato.next_symbol == estado.regra.esquerda
        if (imprimir_regras_producao)
          puts pastel.cyan "[Complete] Estado Candidato: #{estado_candidato}"
        end
        @tabela[index] << estado_candidato.complete(index-1,estado, estado_candidato)
      end
    end
  end
end