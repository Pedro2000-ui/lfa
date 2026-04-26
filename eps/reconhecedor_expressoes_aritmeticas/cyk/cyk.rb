require_relative 'gramatica'
require_relative 'lexer'

class CYKParser
  attr_reader :tabela, :gramatica, :imprimir_regras_producao

  def initialize(gramatica)
    @imprimir_regras_producao = imprimir_regras_producao = false
    @gramatica = gramatica
  end

  def parse(entrada)
    # Exemplo. Quero reconhecer uma L = {a^n b^n | n >= 1}
    # Gramática na forma normal de Chomsky:
    # 
    # S -> AB | AC
    # A -> a
    # B -> b
    # C -> SB
    
    n = entrada.length
    # Cria uma tabela NxN
    @tabela = Array.new(n) { Array.new(n) { [] } }

    @tabela.each_with_index do |coluna, index|
      (0..index-1).each do |i|
        @tabela[index][i] << "⚫️"
      end
    end
    
    ##########################################
    # Exemplo: entrada = "aabb"
    # 
    #  Tabela Inicializada (4x4):
    #  _______________________________________
    #  | a |   |   |   |
    #  | ⚫️ | a |   |   |
    #  | ⚫️ | ⚫️ | b |   |  
    #  | ⚫️ | ⚫️ | ⚫️ | b |
    #
    
    # Passo 1: Analiza os símbolos terminais
    # e adiciona seus não-terminais geradores A->a
    adiciona_terminais(entrada)

    # Depois do passo 1, a tabela ficará assim:
    
    ##########################################
    #  Tabela: 
    #  _______________________________________
    #  | [A] |     |     |     |
    #  |     | [A] |     |     |
    #  |     |     | [B] |     |  
    #  |     |     |     | [B] |
    #
    
    # Passo 2: subir na tabela pelas regras
    # com não-terminais A->BC
    adiciona_nao_terminais(entrada)

    tabela
  end

  def aceito?
    # verifica se o símbolo inicial está 
    # na última linha e primeira coluna da tabela
    tabela[0][-1].include?(gramatica.simbolo_inicial)
  end

  private

  def adiciona_terminais(entrada)
    lista_simbolos_entrada = entrada.split('')
    lista_simbolos_entrada.each_with_index do |simbolo, i|
      @gramatica.regras.each do |regra|
        if terminal?(regra.direita, simbolo)
          tabela[i][i] << regra.esquerda unless tabela[i][i].include?(regra.esquerda)
        end
      end
      # propaga unitárias na diagonal
      propaga_unitarias(i, i)
    end
    if (imprimir_regras_producao)
      imprime_tabela(tabela)
    end
  end

  def adiciona_nao_terminais(entrada)
  n = entrada.length

    for largura in 1...n
      for inicio in 0...(n - largura)
        fim = inicio + largura
        (inicio...fim).each do |meio|
          @gramatica.regras.each do |regra|
            if match_de_nao_terminais?(inicio, meio, fim, regra)
              tabela[inicio][fim] << regra.esquerda unless tabela[inicio][fim].include?(regra.esquerda)
            end
          end
        end
        # propaga unitárias após cada célula ser preenchida
        propaga_unitarias(inicio, fim)
      end
    end
  end

  def propaga_unitarias(linha, col)
    mudou = true
    while mudou
      mudou = false
      @gramatica.regras.each do |regra|
        next unless regra.direita.length == 1
        filho = regra.direita[0]
        if tabela[linha][col].include?(filho) && !tabela[linha][col].include?(regra.esquerda)
          tabela[linha][col] << regra.esquerda
          mudou = true
        end
      end
    end
  end

  def match_de_nao_terminais?(inicio, meio, fim, regra)
    # simbolo terminal
    return false if regra.direita.length < 2 

    # A -> BC 
    # primeira_direita = B
    # segunda_direita = C
    primeira_direita = regra.direita[0]
    segunda_direita = regra.direita[1]

    tabela[inicio][meio].include?(primeira_direita) &&
      tabela[meio + 1][fim].include?(segunda_direita)
  end

  def terminal?(direita, simbolo_lido)
    direita.length == 1 && direita[0] == simbolo_lido
  end

  def imprime_tabela(tabela)
    
    sleep 5
    system "clear"
    puts @gramatica
    puts "\n"
    
    tabela.each do |coluna|
      print "| " 
      coluna.each do |celula|
        print celula.join(",").center(3)
        print " | "
      end
      puts ""
    end
  end
end
