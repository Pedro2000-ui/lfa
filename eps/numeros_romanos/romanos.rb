class TDF
  def initialize(cadeia)
    @cadeia = cadeia.upcase.strip
    @indice = 0
    @max    = @cadeia.size
  end

  def proximo
    if @indice == @max
      ""
    else
      @cadeia[@indice]
    end
  end

  def iniciar
    estado  = "q0"
    retorno = ""

    puts "Máquina iniciou no estado: " + estado

    loop do
      case [proximo, estado]

      # --- Dezenas ---
      in ["X", "q0"]    ; estado = "qX"
      in ["L", "q0"]    ; estado = "qL"
      in ["L", "qX"]    ; retorno += "4" ; estado = "qXL"
      in ["C", "qX"]    ; retorno += "9" ; estado = "qXC"
      in ["X", "qX"]    ; estado = "qXX"
      in ["I", "qX"]    ; retorno += "1" ; estado = "qI" ; @indice += 1 ; next
      in ["V", "qX"]    ; retorno += "1" ; estado = "qV" ; @indice += 1 ; next
      in ["", "qX"]     ; retorno += "1" ; puts "Aceito: #{@cadeia} = #{retorno.to_i}0" ; break
      in ["X", "qXX"]   ; estado = "qXXX"
      in ["I", "qXX"]   ; retorno += "2" ; estado = "qI" ; @indice += 1 ; next
      in ["V", "qXX"]   ; retorno += "2" ; estado = "qV" ; @indice += 1 ; next
      in ["", "qXX"]    ; retorno += "2" ; puts "Aceito: #{@cadeia} = #{retorno.to_i}0" ; break
      in ["I", "qXXX"]  ; retorno += "3" ; estado = "qI" ; @indice += 1 ; next
      in ["V", "qXXX"]  ; retorno += "3" ; estado = "qV" ; @indice += 1 ; next
      in ["", "qXXX"]   ; retorno += "3" ; puts "Aceito: #{@cadeia} = #{retorno.to_i}0" ; break
      in ["I", "qL"]    ; retorno += "5" ; estado = "qI" ; @indice += 1 ; next
      in ["V", "qL"]    ; retorno += "5" ; estado = "qV" ; @indice += 1 ; next
      in ["", "qL"]     ; retorno += "5" ; puts "Aceito: #{@cadeia} = #{retorno.to_i}0" ; break
      in ["X", "qL"]    ; estado = "qLX"
      in ["X", "qLX"]   ; estado = "qLXX"
      in ["X", "qLXX"]  ; estado = "qLXXX"
      in ["I", "qLX"]   ; retorno += "6" ; estado = "qI" ; @indice += 1 ; next
      in ["V", "qLX"]   ; retorno += "6" ; estado = "qV" ; @indice += 1 ; next
      in ["", "qLX"]    ; retorno += "6" ; puts "Aceito: #{@cadeia} = #{retorno.to_i}0" ; break
      in ["I", "qLXX"]  ; retorno += "7" ; estado = "qI" ; @indice += 1 ; next
      in ["V", "qLXX"]  ; retorno += "7" ; estado = "qV" ; @indice += 1 ; next
      in ["", "qLXX"]   ; retorno += "7" ; puts "Aceito: #{@cadeia} = #{retorno.to_i}0" ; break
      in ["I", "qLXXX"] ; retorno += "8" ; estado = "qI" ; @indice += 1 ; next
      in ["V", "qLXXX"] ; retorno += "8" ; estado = "qV" ; @indice += 1 ; next
      in ["", "qLXXX"]  ; retorno += "8" ; puts "Aceito: #{@cadeia} = #{retorno.to_i}0" ; break
      in ["I", "qXL"]   ; retorno += "" ; estado = "qI" ; @indice += 1 ; next
      in ["V", "qXL"]   ; retorno += "" ; estado = "qV" ; @indice += 1 ; next
      in ["", "qXL"]    ; retorno += "" ; puts "Aceito: #{@cadeia} = #{retorno.to_i}0" ; break
      in ["I", "qXC"]   ; retorno += "" ; estado = "qI" ; @indice += 1 ; next
      in ["V", "qXC"]   ; retorno += "" ; estado = "qV" ; @indice += 1 ; next
      in ["", "qXC"]    ; retorno += "" ; puts "Aceito: #{@cadeia} = #{retorno.to_i}0" ; break

      # --- Unidades ---
      in ["I", "q0"]   ; estado = "qI"
      in ["V", "q0"]   ; estado = "qV"
      in ["V", "qI"]   ; retorno += "4" ; estado = "qFim"
      in ["X", "qI"]   ; retorno += "9" ; estado = "qFim"
      in ["I", "qI"]   ; estado = "qII"
      in ["", "qI"]    ; retorno += "1" ; puts "Aceito: #{@cadeia} = #{retorno.to_i}" ; break
      in ["I", "qII"]  ; estado = "qIII"
      in ["", "qII"]   ; retorno += "2" ; puts "Aceito: #{@cadeia} = #{retorno.to_i}" ; break
      in ["", "qIII"]  ; retorno += "3" ; puts "Aceito: #{@cadeia} = #{retorno.to_i}" ; break
      in ["I", "qV"]   ; estado = "qVI"
      in ["", "qV"]    ; retorno += "5" ; puts "Aceito: #{@cadeia} = #{retorno.to_i}" ; break
      in ["I", "qVI"]  ; estado = "qVII"
      in ["", "qVI"]   ; retorno += "6" ; puts "Aceito: #{@cadeia} = #{retorno.to_i}" ; break
      in ["I", "qVII"] ; estado = "qVIII"
      in ["", "qVII"]  ; retorno += "7" ; puts "Aceito: #{@cadeia} = #{retorno.to_i}" ; break
      in ["", "qVIII"] ; retorno += "8" ; puts "Aceito: #{@cadeia} = #{retorno.to_i}" ; break

      # --- Fim ---
      in ["", "qFim"]  ; puts "Aceito: #{@cadeia} = #{retorno.to_i}" ; break

      # --- Erro ---
      else ; puts "Erro: símbolo '#{proximo}' inesperado no estado #{estado}" ; break
      end

      @indice += 1
      puts "Estado: #{estado}"
    end
  end
end

print "Digite o número romano: "
entrada = gets.chomp

tdf = TDF.new(entrada)
tdf.iniciar