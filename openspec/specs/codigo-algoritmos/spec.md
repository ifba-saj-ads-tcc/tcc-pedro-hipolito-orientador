## Purpose

Exibição de código-fonte e algoritmos estruturados (src/code-algo.typ).

## Requirements

### Requirement: Código-fonte
`codigo` SHALL renderizar código como raw (com `lang` opcional para realce), alinhado à esquerda, em figure com `kind` e `supplement` parametrizáveis (padrão `kind: raw`, `supplement: "Código"`), legenda no topo e linha de fonte abaixo (padrão: elaborado pelo próprio autor). Quando `keywords` for informado, as ocorrências exatas das palavras-chave SHALL ser destacadas em negrito dentro do bloco.

#### Scenario: Código de arquivo externo
- **WHEN** `codigo(lang: "javascript", caption: [...], read("server.js"))`
- **THEN** o código aparece com numeração própria e fonte automática

#### Scenario: Código com keywords
- **WHEN** `codigo(keywords: ("se","para"), caption: [...], "se x para y")`
- **THEN** as ocorrências de "se" e "para" aparecem em negrito dentro do raw

### Requirement: Algoritmo como figura
`algoritmo` SHALL ser um wrapper de `codigo` com `lang: "pseudocodigo"`, `kind: "algorithm"`, `supplement: "Algoritmo"`, legenda no topo, fonte abaixo e keywords fixas de pseudocódigo em PT-BR ("se","então","senão","para","cada","faça","retorne","enquanto","fim","procedure","em") destacadas em negrito, habilitando referência cruzada e lista de algoritmos.

#### Scenario: Referência cruzada
- **WHEN** a figura tem label e é usada `@label`
- **THEN** a referência exibe "Algoritmo 1"

#### Scenario: Caption uniformizada
- **WHEN** `codigo` ou `algoritmo` é renderizado com caption
- **THEN** a legenda segue o mesmo formato "Supplement Número – Título" centralizado

### Requirement: Realce via codly
O template SHALL inicializar codly + codly-languages uma única vez quando `codly-habilitado: true`.

#### Scenario: Codly desabilitado
- **WHEN** `codly-habilitado: false`
- **THEN** o código é renderizado como raw simples sem inicialização do codly
