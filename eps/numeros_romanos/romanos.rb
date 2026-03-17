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

      # --- Unidades ---
      in ["I", "q0"]   ; estado = "qI"
      in ["V", "q0"]   ; estado = "qV"
      in ["V", "qI"]   ; retorno += "4" ; puts "Aceito: #{@cadeia} = #{retorno.to_i}" ; break
      in ["X", "qI"]   ; retorno += "9" ; puts "Aceito: #{@cadeia} = #{retorno.to_i}" ; break
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

      # --- Erro ---
      else ; puts "Erro: símbolo '#{proximo}' inesperado no estado #{estado}" ; break
      end

      @indice += 1
      puts "Estado: #{estado}"
    end
  end
end

print "Digite o número romano (I a IX): "
entrada = gets.chomp

tdf = TDF.new(entrada)
tdf.iniciar