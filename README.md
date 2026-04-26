# Linguagens Formais e Autômatos

Repositório voltado para projetos e exercícios da disciplina de **Linguagens Formais e Automatos**.

O conteúdo está organizado em duas categorias principais:

- **Exercícios** – implementações menores voltadas para prática de conceitos.
- **EPs (Exercícios-Programa)** – projetos mais completos desenvolvidos ao longo da disciplina.

## Estrutura do Repositório

### Exercícios
Implementações e experimentos relacionados aos conteúdos da disciplina.

- [exercicios/](exercicios)

### EPs
Projetos completos desenvolvidos durante a disciplina.

- [Números Romanos](eps/numeros_romanos/docs/README.md)
- [Reconhecedor de Expressões Aritméticas](eps/reconhecedor_expressoes_aritmeticas/docs/README.md)

## Como Executar os Projetos Ruby

### 1. Instalar o Ruby

**Windows:** Baixe em [rubyinstaller.org](https://rubyinstaller.org) (recomendado: Ruby 3.x with Devkit).

**Mac:**
```bash
brew install ruby
```

**Linux:**
```bash
sudo apt install ruby
```

### 2. Instalar as dependências

```bash
gem install pastel
gem install tty-table
```

### 3. Navegar até a raiz do projeto ou exercício

Cada projeto possui seus próprios arquivos `.rb`. Antes de executar, navegue até a pasta raiz do respectivo projeto ou exercício. Por exemplo:

```bash
# Para um EP
cd eps/reconhecedor_expressoes_aritmeticas

# Para um exercício
cd exercicios/nome_do_exercicio
```

### 4. Executar

Cada projeto possui um arquivo `.rb` principal (o nome pode variar conforme o projeto — verifique o README de cada um). Para executá-lo:

```bash
ruby nome_do_arquivo.rb
```