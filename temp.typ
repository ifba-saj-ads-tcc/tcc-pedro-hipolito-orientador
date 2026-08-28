// Função auxiliar fictícia para o exemplo compilar
#let _render-source(source) = {
  if source != auto [ \ Fonte: #source_ ]
}

#let tabela(
  caption: none,
  source: auto,
  columns: auto,
  align: auto,
  header: none,
  ..rows,
) = {
  figure(
    {
      table(
        columns: columns,
        align: align,
        stroke: none, // Remove as bordas padrão para não sobrepor
        inset: (x: 6pt, y: 7pt), // Um pouco mais de espaço vertical melhora a leitura
        
        // Linha superior da tabela
        table.hline(stroke: 1.5pt),
        
        // Estrutura do cabeçalho com sua linha divisória inferior
        if header != none {
          table.header(
            ..header.map(h => [ *#h* ]) // Deixa o texto do cabeçalho em negrito automaticamente
          )
        },
        
        // Linha abaixo do cabeçalho (renderiza logo após a linha 0)
        if header != none { table.hline(start: 0, stroke: 0.8pt) },
        
        // Dados da tabela
        ..rows.pos(),
        
        // Linha inferior de fechamento
        table.hline(stroke: 1.5pt),
      )
      _render-source(source)
    },
    caption: caption,
    numbering: "1",
    kind: table,
    supplement: [Tabela],
  )
}

// Chamada da função (Note que corrigi o alinhamento para cobrir as 8 colunas)
#tabela(
  caption: [Exemplo de métricas por modelo], 
  columns: (1.5fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr), 
  align: (left, center, center, center, center, center, center, center),
  header: ([Parâmetro], [GPT-5.5], [Claude], [Llama], [Qwen], [Gemini], [Nemotron], [North]), 
  [cost], [0.107], [0.114], [0.006], [0.011], [0.012], [0.005], [0.005],
  [response_time_ms], [44059], [11028], [2634], [47734], [10398], [3910], [6445],
  [prompt_tokens], [15370], [19821], [3658], [3837], [524], [3982], [3655],
  [completion_tokens], [972], [227], [48], [2496], [1336], [351], [497]
) <tab:exemplo_retorno_nemotron>