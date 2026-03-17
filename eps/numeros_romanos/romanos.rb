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

      # --- Milhar ---
      in ["M", "q0"]    ; estado = "qM"
      in ["M", "qM"]    ; estado = "qMM"
      in ["M", "qMM"]   ; estado = "qMMM"
      in ["C", "qM"]    ; retorno += "1" ; estado = "qC" ; @indice += 1 ; next
      in ["D", "qM"]    ; retorno += "1" ; estado = "qD" ; @indice += 1 ; next
      in ["X", "qM"]    ; retorno += "10" ; estado = "qX" ; @indice += 1 ; next
      in ["L", "qM"]    ; retorno += "10" ; estado = "qL" ; @indice += 1 ; next
      in ["I", "qM"]    ; retorno += "100" ; estado = "qI" ; @indice += 1 ; next
      in ["V", "qM"]    ; retorno += "100" ; estado = "qV" ; @indice += 1 ; next
      in ["", "qM"]     ; retorno += "1" ; puts "Aceito: #{@cadeia} = #{retorno.to_i}000" ; break
      in ["C", "qMM"]   ; retorno += "2" ; estado = "qC" ; @indice += 1 ; next
      in ["D", "qMM"]   ; retorno += "2" ; estado = "qD" ; @indice += 1 ; next
      in ["X", "qMM"]   ; retorno += "20" ; estado = "qX" ; @indice += 1 ; next
      in ["L", "qMM"]   ; retorno += "20" ; estado = "qL" ; @indice += 1 ; next
      in ["I", "qMM"]   ; retorno += "200" ; estado = "qI" ; @indice += 1 ; next
      in ["V", "qMM"]   ; retorno += "200" ; estado = "qV" ; @indice += 1 ; next
      in ["", "qMM"]    ; retorno += "2" ; puts "Aceito: #{@cadeia} = #{retorno.to_i}000" ; break
      in ["C", "qMMM"]  ; retorno += "3" ; estado = "qC" ; @indice += 1 ; next
      in ["D", "qMMM"]  ; retorno += "3" ; estado = "qD" ; @indice += 1 ; next
      in ["X", "qMMM"]  ; retorno += "30" ; estado = "qX" ; @indice += 1 ; next
      in ["L", "qMMM"]  ; retorno += "30" ; estado = "qL" ; @indice += 1 ; next
      in ["I", "qMMM"]  ; retorno += "300" ; estado = "qI" ; @indice += 1 ; next
      in ["V", "qMMM"]  ; retorno += "300" ; estado = "qV" ; @indice += 1 ; next
      in ["", "qMMM"]   ; retorno += "3" ; puts "Aceito: #{@cadeia} = #{retorno.to_i}000" ; break

      # --- Centenas ---
      in ["C", "q0"]     ; estado = "qC"
      in ["D", "q0"]     ; estado = "qD"
      in ["D", "qC"]     ; retorno += "4" ; estado = "qCD"
      in ["M", "qC"]     ; retorno += "9" ; estado = "qCM"
      in ["C", "qC"]     ; estado = "qCC"
      in ["X", "qC"]     ; retorno += "1" ; estado = "qX" ; @indice += 1 ; next
      in ["L", "qC"]     ; retorno += "1" ; estado = "qL" ; @indice += 1 ; next
      in ["I", "qC"]     ; retorno += "10" ; estado = "qI" ; @indice += 1 ; next
      in ["V", "qC"]     ; retorno += "10" ; estado = "qV" ; @indice += 1 ; next
      in ["", "qC"]      ; retorno += "1" ; puts "Aceito: #{@cadeia} = #{retorno.to_i}00" ; break
      in ["C", "qCC"]    ; estado = "qCCC"
      in ["X", "qCC"]    ; retorno += "2" ; estado = "qX" ; @indice += 1 ; next
      in ["L", "qCC"]    ; retorno += "2" ; estado = "qL" ; @indice += 1 ; next
      in ["I", "qCC"]    ; retorno += "2" ; estado = "qI" ; @indice += 1 ; next
      in ["V", "qCC"]    ; retorno += "2" ; estado = "qV" ; @indice += 1 ; next
      in ["", "qCC"]     ; retorno += "2" ; puts "Aceito: #{@cadeia} = #{retorno.to_i}00" ; break
      in ["X", "qCCC"]   ; retorno += "3" ; estado = "qX" ; @indice += 1 ; next
      in ["L", "qCCC"]   ; retorno += "3" ; estado = "qL" ; @indice += 1 ; next
      in ["I", "qCCC"]   ; retorno += "3" ; estado = "qI" ; @indice += 1 ; next
      in ["V", "qCCC"]   ; retorno += "3" ; estado = "qV" ; @indice += 1 ; next
      in ["", "qCCC"]    ; retorno += "3" ; puts "Aceito: #{@cadeia} = #{retorno.to_i}00" ; break
      in ["X", "qD"]     ; retorno += "5" ; estado = "qX" ; @indice += 1 ; next
      in ["L", "qD"]     ; retorno += "5" ; estado = "qL" ; @indice += 1 ; next
      in ["I", "qD"]     ; retorno += "50" ; estado = "qI" ; @indice += 1 ; next
      in ["V", "qD"]     ; retorno += "50" ; estado = "qV" ; @indice += 1 ; next
      in ["", "qD"]      ; retorno += "5" ; puts "Aceito: #{@cadeia} = #{retorno.to_i}00" ; break
      in ["C", "qD"]     ; estado = "qDC"
      in ["C", "qDC"]    ; estado = "qDCC"
      in ["C", "qDCC"]   ; estado = "qDCCC"
      in ["X", "qDC"]    ; retorno += "6" ; estado = "qX" ; @indice += 1 ; next
      in ["L", "qDC"]    ; retorno += "6" ; estado = "qL" ; @indice += 1 ; next
      in ["I", "qDC"]    ; retorno += "6" ; estado = "qI" ; @indice += 1 ; next
      in ["V", "qDC"]    ; retorno += "6" ; estado = "qV" ; @indice += 1 ; next
      in ["", "qDC"]     ; retorno += "6" ; puts "Aceito: #{@cadeia} = #{retorno.to_i}00" ; break
      in ["X", "qDCC"]   ; retorno += "7" ; estado = "qX" ; @indice += 1 ; next
      in ["L", "qDCC"]   ; retorno += "7" ; estado = "qL" ; @indice += 1 ; next
      in ["I", "qDCC"]   ; retorno += "7" ; estado = "qI" ; @indice += 1 ; next
      in ["V", "qDCC"]   ; retorno += "7" ; estado = "qV" ; @indice += 1 ; next
      in ["", "qDCC"]    ; retorno += "7" ; puts "Aceito: #{@cadeia} = #{retorno.to_i}00" ; break
      in ["X", "qDCCC"]  ; retorno += "8" ; estado = "qX" ; @indice += 1 ; next
      in ["L", "qDCCC"]  ; retorno += "8" ; estado = "qL" ; @indice += 1 ; next
      in ["I", "qDCCC"]  ; retorno += "8" ; estado = "qI" ; @indice += 1 ; next
      in ["V", "qDCCC"]  ; retorno += "8" ; estado = "qV" ; @indice += 1 ; next
      in ["", "qDCCC"]   ; retorno += "8" ; puts "Aceito: #{@cadeia} = #{retorno.to_i}00" ; break
      in ["X", "qCD"]    ; retorno += "" ; estado = "qX" ; @indice += 1 ; next
      in ["L", "qCD"]    ; retorno += "" ; estado = "qL" ; @indice += 1 ; next
      in ["I", "qCD"]    ; retorno += "0" ; estado = "qI" ; @indice += 1 ; next
      in ["V", "qCD"]    ; retorno += "0" ; estado = "qV" ; @indice += 1 ; next
      in ["", "qCD"]     ; retorno += "" ; puts "Aceito: #{@cadeia} = #{retorno.to_i}00" ; break
      in ["X", "qCM"]    ; retorno += "" ; estado = "qX" ; @indice += 1 ; next
      in ["L", "qCM"]    ; retorno += "" ; estado = "qL" ; @indice += 1 ; next
      in ["I", "qCM"]    ; retorno += "0" ; estado = "qI" ; @indice += 1 ; next
      in ["V", "qCM"]    ; retorno += "0" ; estado = "qV" ; @indice += 1 ; next
      in ["", "qCM"]     ; retorno += "" ; puts "Aceito: #{@cadeia} = #{retorno.to_i}00" ; break

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

print "Digite o número romano (até 3999): "
entrada = gets.chomp

tdf = TDF.new(entrada)
tdf.iniciar