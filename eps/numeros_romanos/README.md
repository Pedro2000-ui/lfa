# Transdutor: Conversor de números romanos

## Descrição

Este projeto implementa um Transdutor Finito Determinístico (TFD) em Ruby que converte
numerais romanos para sua representação decimal. A máquina processa a cadeia de entrada
um caractere por vez, sem uso de tabelas de símbolos, hashes ou bibliotecas externas.
O intervalo suportado é de I (1) a MMMCMXCIX (3999).

---

## Definição Formal

Um Transdutor Finito Determinístico é definido por:

    T = (Q, Sigma, Delta, q0, F, delta, lambda)

Onde:

- Q       : conjunto finito de estados
- Sigma   : alfabeto de entrada
- Delta   : alfabeto de saída
- q0      : estado inicial
- F       : conjunto de estados de aceitação
- delta   : Regras de transição
- lambda  : Regras de Emissão

Para este transdutor:

    Q = { q0, qM, qMM, qMMM,
          qC, qCC, qCCC, qD, qDC, qDCC, qDCCC, qCD, qCM,
          qX, qXX, qXXX, qL, qLX, qLXX, qLXXX, qXL, qXC,
          qI, qII, qIII, qV, qVI, qVII, qVIII,
          qIV, qIX, qFim }

    Sigma = { M, D, C, L, X, V, I, "" }
            onde "" representa o fim de cadeia

    Delta = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9" }*
            (sequencias de dígitos decimais concatenadas em retorno)

    q0    = q0

    F     = todos os estados que aceitam ao receber ""

---

## Tipo de Transdutor: Mealy

Este transdutor segue o modelo de Mealy, no qual a saída é associada
às transições e não aos estados.

Na máquina de Moore, a saída depende apenas do estado atual. Na máquina
de Mealy, a saída depende do estado atual e do símbolo lido. Esta
implementação é de Mealy porque:

1. A saída (concatenação em `retorno`) ocorre no momento da transição,
   ao processar o par (estado_atual, simbolo_lido).
2. O mesmo estado pode produzir saídas diferentes dependendo do símbolo
   recebido. Por exemplo, qX ao receber "I" emite "1", ao receber "L"
   emite "4", e ao receber "X" não emite nada e só troca de estado.
3. Não existe um valor de saída fixo associado a cada estado
   independentemente da entrada.

---

## Alfabeto de Entrada (Sigma)

| Símbolo | Valor romano |
|---------|--------------|
| M       | 1000         |
| D       | 500          |
| C       | 100          |
| L       | 50           |
| X       | 10           |
| V       | 5            |
| I       | 1            |
| ""      | fim de cadeia|

---

## Alfabeto de Saída (Delta)

A saída é uma string de dígitos decimais construída concatenamente
durante as transições. Cada fragmento emitido representa o valor
posicional da grandeza reconhecida até aquele momento. Zeros são
inseridos explicitamente quando grandezas intermediárias estão ausentes,
para preservar o alinhamento posicional da string resultante.

Exemplos de fragmentos emitidos:

| Fragmento | Situação                                              |
|-----------|-------------------------------------------------------|
| "1"       | qC reconheceu uma centena simples                     |
| "10"      | qM transita para dezena, centena estava ausente       |
| "100"     | qM transita para unidade, centena e dezena ausentes   |
| "4"       | qXL ou qCD reconheceram valor subtrativo              |
| "0"       | qCD ou qCM transitam para unidade sem dezena          |
| ""        | transição sem emissão (estado aguarda próximo símbolo)|

---

## Transições sem Saída

Algumas transições apenas mudam de estado sem emitir símbolo. Isso ocorre
quando a máquina ainda não tem informação suficiente para determinar o
valor da grandeza atual, pois precisa aguardar o próximo símbolo para
decidir entre um valor simples ou uma forma subtrativa.

Exemplos:

    (q0,   M) -> qM,   saída: nenhuma   -- pode ser M, MM ou MMM
    (q0,   C) -> qC,   saída: nenhuma   -- pode ser C, CC, CCC, CD ou CM
    (qC,   C) -> qCC,  saída: nenhuma   -- pode ser CC ou CCC
    (q0,   X) -> qX,   saída: nenhuma   -- pode ser X, XX, XXX, XL ou XC
    (qX,   X) -> qXX,  saída: nenhuma   -- pode ser XX ou XXX
    (q0,   I) -> qI,   saída: nenhuma   -- pode ser I, II, III, IV ou IX
    (qI,   I) -> qII,  saída: nenhuma   -- pode ser II ou III
    (qL,   X) -> qLX,  saída: nenhuma   -- pode ser LX, LXX ou LXXX
    (qD,   C) -> qDC,  saída: nenhuma   -- pode ser DC, DCC ou DCCC

---

## Transições com Saída

Quando a máquina determina o valor de uma grandeza, seja por receber um
símbolo de grandeza menor (transição para nível inferior) ou por chegar
ao fim de cadeia, ela emite o fragmento correspondente.

Exemplos:

    (qM,   C) -> qC,   saída: "1"    -- milhar=1, passa centena adiante
    (qM,   X) -> qX,   saída: "10"   -- milhar=1, centena ausente (zero)
    (qM,   I) -> qI,   saída: "100"  -- milhar=1, centena e dezena ausentes
    (qC,   X) -> qX,   saída: "1"    -- centena=1, passa dezena adiante
    (qC,   I) -> qI,   saída: "10"   -- centena=1, dezena ausente (zero)
    (qD,   I) -> qI,   saída: "50"   -- centena=5, dezena ausente (zero)
    (qX,   L) -> qXL,  saída: "4"    -- forma subtrativa XL=40
    (qX,   C) -> qXC,  saída: "9"    -- forma subtrativa XC=90
    (qX,   I) -> qI,   saída: "1"    -- dezena=1, passa unidade adiante
    (qI,   V) -> qFim, saída: "4"    -- forma subtrativa IV=4
    (qI,   X) -> qFim, saída: "9"    -- forma subtrativa IX=9
    (qII,  "") -> aceita, saída: "2" -- fim de cadeia, II=2

---

## Estratégia de Saída: Concatenação Posicional

A saída não é acumulada numericamente, mas como uma string de dígitos
que representa o número decimal posição a posição. Ao final, a string é
convertida para inteiro com `to_i`, e zeros de posições ausentes são
acrescentados conforme a grandeza do estado de aceitação:

    retorno.to_i}000   -- aceitação no milhar
    retorno.to_i}00    -- aceitação na centena
    retorno.to_i}0     -- aceitação na dezena
    retorno.to_i       -- aceitação na unidade

Isso evita aritmética de soma e mantém a lógica inteiramente nas
transições de estado.

---

## Exemplo de Execução: MCMXCIX (1999)

| Passo | Estado atual | Símbolo lido | Próximo estado | Saída emitida |
|-------|--------------|--------------|----------------|---------------|
| 1     | q0           | M            | qM             | -             |
| 2     | qM           | C            | qC             | "1"           |
| 3     | qC           | M            | qCM            | "9"           |
| 4     | qCM          | X            | qX             | -             |
| 5     | qX           | C            | qXC            | "9"           |
| 6     | qXC          | I            | qI             | -             |
| 7     | qI           | X            | qFim           | "9"           |
| 8     | qFim         | ""           | aceita         | -             |

retorno = "1" + "9" + "9" + "9" = "1999"
resultado = "1999".to_i = 1999

---

## Exemplo de Execução: XLII (42)

| Passo | Estado atual | Símbolo lido | Próximo estado | Saída emitida |
|-------|--------------|--------------|----------------|---------------|
| 1     | q0           | X            | qX             | -             |
| 2     | qX           | L            | qXL            | "4"           |
| 3     | qXL          | I            | qI             | -             |
| 4     | qI           | I            | qII            | -             |
| 5     | qII          | ""           | aceita         | "2"           |

retorno = "4" + "2" = "42"
resultado = "42".to_i = 42

---

## Execução

    ruby romanos.rb

A máquina solicita a entrada ao usuário, processa caractere a caractere
e exibe cada transição de estado até a aceitação ou erro.

---

## Diagrama
Abaixo um esboço do diagrama para geração dos estados e implementação do código em ruby:

<img width="4213" height="3999" alt="Diagrama em branco" src="https://github.com/user-attachments/assets/934255ad-cbd2-4d69-98b5-85602ad6677c" />
