#import "ifbasaj-tcc/imports.typ": *
#show: template.with(
  titulo: "Centro de Ajuda: Sistema Inteligente de Recomendação de Comunicação em Situações Emergenciais",
  autor: "Pedro Victor Hipólito Cabral",
  orientador: "Prof. Leandro Costa Souza",
  data-banca: datetime(year: 2026, month: 9, day: 18),
  resumo-conteudo: [Este trabalho apresenta o desenvolvimento de uma prova de conceito de um sistema inteligente para redirecionamento de solicitações emergenciais, denominado Centro de Ajuda, que utiliza inteligência artificial multimodal para interpretar relatos em texto, áudio e imagem e recomendar o serviço de emergência mais adequado.],
  resumo-palavras: ("Inteligência Artificial", "Emergência", "Multimodal", "LLM"),
  abstract-conteudo: [This work presents a proof of concept of an intelligent emergency redirection system called Centro de Ajuda, using multimodal AI to interpret text, audio and image reports and recommend the most appropriate emergency service.],
  abstract-palavras: ("Artificial Intelligence", "Emergency", "Multimodal", "LLM"),
  banca: (
    [Prof. Mst. Leandro Costa Souza (IFBA)],
    [Prof. Dr. (IFBA)],
    [Prof. Dr. (IFBA)],
  ),
  //ficha-catalografica: image("assets/ficha-exemplo.pdf", width: 100%, height: 100%, fit: "contain"),
  ficha-catalografica: [criação da ficha],
  bibliografia: read("referencias.bib"),
  versao-impressao: false,
)

// Mantém código inline no parágrafo, sem aplicar o bloco visual de listagens.
#show raw.where(block: false): it => text(font: "Consolas", size: 0.85em, it.text)

= Introdução

Identificar o serviço adequado é uma etapa necessária para solicitar ajuda em uma situação de emergência. No Brasil, a existência de números distintos para diferentes órgãos exige que o cidadão reconheça a natureza da ocorrência e saiba a quem recorrer. A dificuldade de diferenciar esses serviços, documentada por #prose("revistaUnijui2024"), motiva a investigação de recursos que auxiliem essa escolha.

Este trabalho apresenta o Centro de Ajuda, uma prova de conceito que utiliza inteligência artificial para interpretar relatos em texto, áudio e imagem e recomendar um serviço de atendimento. A introdução delimita o contexto e o problema investigado, justifica a proposta, apresenta seus objetivos e sintetiza os resultados obtidos.

== Contextualização

=== Número de emergência universal

Segundo #prose("mossEloise"), um número de emergência universal centraliza o acesso a diferentes serviços de socorro em um único identificador telefônico. Nesse modelo, o cidadão não precisa escolher previamente entre os números de cada órgão: a central recebe a solicitação e a encaminha conforme a natureza da ocorrência.

O Reino Unido, com o número 999, e os Estados Unidos, com o 911, exemplificam a adoção desse modelo. A centralização do acesso, contudo, depende da organização dos serviços de atendimento e de sua integração institucional e tecnológica, que variam entre os países #cite("mossEloise").

=== Números de emergência no Brasil

No Brasil, o acesso ao atendimento emergencial é distribuído entre números associados a diferentes órgãos. Entre eles estão o 190, da Polícia Militar; o 192, do #abbrev("SAMU", long: "Serviço de Atendimento Móvel de Urgência"); e o 193, do Corpo de Bombeiros. Essa organização diferencia os serviços conforme suas atribuições, mas exige que a população conheça os canais disponíveis e identifique qual deles corresponde à situação enfrentada #cite("anatel2025").

A pesquisa de #prose("revistaUnijui2024") identificou diferenças no reconhecimento desses números entre os participantes. O 190 apresentou 92,2% de reconhecimento correto, enquanto o 192 e o 193 alcançaram 72,6% e 70,8%, respectivamente. No mesmo estudo, 23% dos entrevistados associaram incorretamente o 192 ao Corpo de Bombeiros, e 24,2% relacionaram o 193 ao #abbrev("SAMU"). Esses resultados evidenciam dificuldades de diferenciação dos serviços na amostra investigada.

== Problema de Pesquisa

A existência de canais especializados não garante que o cidadão consiga selecionar o atendimento adequado. Relatos podem ser incompletos, envolver mais de um tipo de risco ou ser apresentados em condições de estresse. Além disso, a necessidade de identificar um serviço local pode exigir informações que vão além da memorização dos números nacionais.

Diante desse problema, este trabalho investiga a seguinte questão: em que medida uma prova de conceito baseada em modelos de linguagem pode interpretar relatos emergenciais em texto, áudio e imagem, considerando sua localização, e produzir uma recomendação estruturada de serviço e contato?

A investigação limita-se à viabilidade técnica da interpretação e da recomendação. Não abrange o despacho de equipes, a integração operacional com centrais oficiais ou a comprovação de redução do tempo de atendimento em ocorrências reais.

== Justificativa

As dificuldades de reconhecimento dos números de emergência identificadas por #prose("revistaUnijui2024") justificam o estudo de mecanismos que auxiliem o cidadão a identificar um canal de atendimento. Uma interface que aceite diferentes formas de relato pode ampliar as possibilidades de comunicação, enquanto a inclusão da localização permite contextualizar a recomendação.

Do ponto de vista técnico, a proposta permite examinar se as capacidades multimodais dos modelos estão efetivamente disponíveis nas interfaces utilizadas pela aplicação. Também permite distinguir três aspectos que não são equivalentes: a aceitação de uma requisição, a compreensão do relato e a adequação do serviço recomendado.

A contribuição pretendida é fornecer uma base experimental para o desenvolvimento de ferramentas de apoio ao direcionamento de solicitações. Eventuais benefícios para a população dependem de avaliações posteriores de usabilidade, confiabilidade e segurança em condições de uso real.

=== Trabalhos Relacionados

O #emph[RapidSOS] utiliza dados provenientes de dispositivos e aplicações para complementar as informações disponíveis às centrais de atendimento emergencial, incluindo localização e outros elementos contextuais #cite("rapidSOS2025"). Sua relação com este trabalho está no uso de informações adicionais para apoiar o atendimento. O Centro de Ajuda concentra-se na etapa de interpretação do relato e apresentação de uma recomendação ao usuário.

Os sistemas 911 e 112, por sua vez, constituem referências de centralização do acesso aos serviços emergenciais. Eles organizam o contato com diferentes órgãos por um canal telefônico comum, apoiado na infraestrutura das centrais responsáveis #cite("nena911", "eena112"). A proposta aqui investigada atua como uma camada de apoio anterior ao contato, sem implementar uma central universal ou substituir a estrutura pública de atendimento.

== Proposta e Objetivos

=== Objetivo Geral

Desenvolver e avaliar uma prova de conceito do Centro de Ajuda, capaz de utilizar modelos de linguagem para interpretar relatos emergenciais em texto, áudio e imagem e retornar uma recomendação estruturada de serviço, telefone e contexto da ocorrência.

A solução foi organizada em uma arquitetura cliente-servidor. O cliente reúne as informações fornecidas pelo usuário, enquanto o servidor prepara o contexto, realiza a integração com os serviços externos e processa a resposta do modelo. A localização geográfica e o horário complementam o relato. A recomendação serve como apoio à decisão, permanecendo o contato com o serviço sob responsabilidade do usuário.

O fluxo geral de interação entre usuário, servidor e inteligência artificial pode ser visualizado na @fig:diagrama_introducao_objetivo_interacao.

#figura(
  image("assets/imagens/diagrama-introducao.png", width: 90%),
  caption: [Fluxo de interação entre usuário, servidor e inteligência artificial],
) <fig:diagrama_introducao_objetivo_interacao>

=== Objetivos Específicos

+ definir o fluxo de interação e os requisitos de uma interface para relatos em texto, áudio e imagem;
+ implementar o servidor responsável pelo recebimento das solicitações e pela integração com os serviços externos;
+ incorporar localização geográfica e horário ao contexto enviado aos modelos;
+ estruturar os prompts e o tratamento da resposta nos campos de serviço, telefone e resumo da ocorrência;
+ comparar sete modelos em quatro cenários padronizados, considerando compatibilidade, estrutura da resposta, interpretação, tempo e custo;
+ identificar limitações observadas nas execuções e possibilidades de composição com modelos auxiliares.

== Síntese dos Resultados

O trabalho resultou na implementação do processamento no servidor e na avaliação de sete modelos por meio do OpenRouter. Nos quatro cenários utilizados, o Gemini 3.5 Flash foi o único modelo isolado que produziu respostas estruturadas e interpretações compatíveis com todas as combinações de entrada. Os demais apresentaram restrições de modalidade, erros de execução ou problemas de compreensão, detalhados no capítulo de análise dos resultados.

Esses resultados sustentam a viabilidade técnica inicial da proposta nas condições avaliadas. Não comprovam a exatidão de todos os contatos recomendados, a eficácia em situações reais ou a conclusão integral da aplicação cliente. A análise de possíveis composições entre modelos complementa os testes, mas exige validação experimental própria antes de permitir conclusões sobre desempenho.

= Revisão Bibliográfica

Para desenvolver um aplicativo capaz de utilizar inteligência artificial para interpretar situações emergenciais, compreender diferentes tipos de entrada de dados e auxiliar no direcionamento contextual de solicitações, torna-se necessário compreender os principais conceitos e tecnologias relacionados à área. Esta seção apresenta os fundamentos teóricos que sustentam o desenvolvimento da proposta, abordando conceitos de inteligência artificial, aprendizado de máquina, redes neurais, modelos de linguagem e processamento multimodal. 

== Inteligência Artificial

Segundo #prose("russelNorvig"), a inteligência artificial corresponde a uma área da computação voltada ao desenvolvimento de sistemas capazes de executar tarefas que normalmente exigiriam capacidades cognitivas humanas, como reconhecimento de padrões, interpretação de linguagem, tomada de decisão e resolução de problemas. Segundo sua abordagem, a inteligência artificial pode ser definida como o estudo de agentes inteligentes, isto é, sistemas capazes de perceber o ambiente ao seu redor e realizar ações com o objetivo de maximizar suas chances de sucesso em determinada tarefa.

=== Aprendizado de Máquina

A principal base para a inteligência artificial moderna é o aprendizado de máquina, também conhecido como #emph[machine learning]. Essa área consiste no desenvolvimento de modelos computacionais capazes de aprender padrões e relações a partir de dados, permitindo que sistemas realizem previsões, classificações e tomadas de decisão sem depender exclusivamente de regras programadas manualmente.

Segundo #prose("mitchell1997"), um programa é capaz de aprender a partir da experiência obtida durante a execução de uma tarefa, melhorando seu desempenho conforme novos dados são analisados. Essa definição estabelece o aprendizado de máquina como um processo baseado em adaptação contínua, no qual os sistemas ajustam seus parâmetros internos de acordo com os padrões identificados durante o treinamento e utilização do modelo.

Esse conceito tornou-se um dos principais pilares da inteligência artificial devido à sua capacidade de identificar padrões complexos em grandes volumes de dados. Em vez de depender apenas de instruções fixas, modelos de aprendizado de máquina conseguem construir representações estatísticas capazes de reconhecer relações entre diferentes variáveis, permitindo aplicações em reconhecimento de voz, visão computacional, sistemas de recomendação, detecção de fraudes e processamento de linguagem natural #cite("ibmML").

De modo geral, os métodos de aprendizado de máquina podem ser divididos em três principais categorias: aprendizado supervisionado, aprendizado não supervisionado e aprendizado por reforço. No aprendizado supervisionado, o modelo é treinado utilizando exemplos rotulados, nos quais já existe uma resposta esperada associada aos dados de entrada. Essa abordagem é amplamente utilizada em tarefas de classificação e previsão. No aprendizado não supervisionado, os dados não possuem rótulos prévios, cabendo ao sistema identificar padrões, agrupamentos e relações ocultas nos dados analisados. Já o aprendizado por reforço consiste em um processo no qual agentes computacionais aprendem por tentativa e erro a partir de recompensas e penalidades recebidas durante interações com um ambiente #cite("ibmML").

=== Redes Neurais e Deep Learning

Entre as principais abordagens utilizadas no aprendizado de máquina moderno, destacam-se as redes neurais artificiais e as técnicas de #emph[deep learning]. Essas estruturas tornaram-se responsáveis por grande parte dos avanços recentes da inteligência artificial, especialmente em tarefas relacionadas ao reconhecimento de padrões complexos, interpretação de linguagem natural, visão computacional e processamento de áudio.

As redes neurais artificiais consistem em modelos computacionais inspirados no funcionamento biológico do cérebro humano. Sua estrutura é composta por neurônios artificiais interconectados, organizados em camadas responsáveis por receber, processar e transmitir informações. Durante o treinamento, os pesos dessas conexões são ajustados matematicamente com o objetivo de minimizar erros e melhorar a capacidade do modelo em reconhecer padrões presentes nos dados analisados #cite("goodfellow2016").

Segundo #prose("goodfellow2016"), uma das principais características das redes neurais é sua capacidade de aprender representações hierárquicas dos dados. Isso significa que diferentes camadas da rede conseguem identificar níveis progressivamente mais complexos de informação. Em reconhecimento de imagens, por exemplo, camadas iniciais podem identificar linhas e bordas simples, enquanto camadas mais profundas passam a reconhecer formas, objetos e relações contextuais completas.

Dessa forma, o termo #emph[deep learning], também conhecido como aprendizado profundo, refere-se à utilização de redes neurais compostas por múltiplas camadas ocultas. O aumento da profundidade dessas arquiteturas permitiu avanços significativos no desempenho de modelos de inteligência artificial,bespecialmente em aplicações envolvendo grandes volumes de dados. Diferentemente de métodos tradicionais, nos quais características relevantes precisavam ser definidas manualmente, modelos de aprendizado profundo conseguem aprender automaticamente representações internas diretamente a partir dos dados utilizados durante o treinamento.

Eventualmente, diferentes arquiteturas de redes neurais passaram a ser desenvolvidas para resolver problemas específicos. Entre os principais exemplos estão as redes neurais convolucionais (#abbrev("CNNs", long: "Convolutional Neural Networks")amplamente utilizadas em tarefas de visão computacional e reconhecimento de imagens, e as redes neurais recorrentes (#abbrev("RNNs", long:"Recurrent Neural Networks")) desenvolvidas para lidar com dados sequenciais, como textos e traduções automáticas #cite("goodfellow2016").

Segundo #prose("goodfellow2016"), as redes neurais recorrentes possuem a capacidade de manter informações relacionadas a estados anteriores durante o processamento da sequência, permitindo que o modelo considere o contexto de elementos previamente analisados. Essa característica tornou as #abbrev("RNNs") uma das principais abordagens utilizadas nas primeiras aplicações modernas de processamento de linguagem natural, reconhecimento de fala e tradução automática.

Apesar de representarem um avanço significativo em relação a modelos tradicionais, arquiteturas recorrentes apresentavam limitações relacionadas à dificuldade de processamento paralelo e à perda de informações em sequências muito longas, problema conhecido como #emph[vanishing gradient]. Essas limitações impulsionaram o desenvolvimento de arquiteturas mais eficientes para interpretação contextual e processamento de grandes volumes de dados sequenciais #cite("goodfellow2016").

=== Arquitetura Transformer

Diferente de arquiteturas anteriores, como #abbrev("RNNs"), #emph[Transformer] foi desenvolvido com o objetivo de processar informações de maneira paralela, reduzindo limitações relacionadas à dependência sequencial dos dados. Enquanto modelos recorrentes analisavam palavras e informações uma após a outra, a arquitetura #emph[Transformer] passou a processar sequências inteiras simultaneamente, aumentando significativamente a eficiência computacional e a capacidade de treinamento em grandes conjuntos de dados #cite("vaswani2017").

O principal componente responsável pelo funcionamento desta arquitetura é o mecanismo de atenção, especialmente o chamado #emph[self-attention].  Esse mecanismo permite que o modelo avalie a relevância de diferentes elementos de uma sequência em relação aos demais elementos presentes no mesmo contexto. Dessa forma, o #emph[Transformer] consegue compreender relações semânticas entre palavras, identificar dependências contextuais distantes e interpretar significados de maneira mais consistente #cite("vaswani2017").

Segundo #prose("vaswani2017"), Outra vantagem substancial da arquitetura #emph[Transformer] é sua escalabilidade. O modelo demonstrou elevada capacidade de desempenho conforme aumentavam o volume de dados utilizados durante o treinamento e a quantidade de parâmetros presentes na rede neural. Essa característica contribuiu diretamente para o desenvolvimento de modelos modernos capazes de realizar tarefas complexas de interpretação contextual, geração de texto e raciocínio baseado em linguagem natural.

== LLMs

A elevada escalabilidade da arquitetura #emph[Transformer] possibilitou o desenvolvimento dos chamados modelos de linguagem de grande porte (#abbrev("LLMs", long: "Large Language Models")). Esses modelos consistem em redes neurais treinadas em enormes volumes de dados textuais com o objetivo de identificar padrões estatísticos, relações semânticas e estruturas linguísticas presentes na linguagem humana..

Segundo #prose("brown2020"), os #abbrev("LLMs") são capazes de aprender relações contextuais complexas entre palavras, frases e conceitos por meio do treinamento em grandes conjuntos de dados. Durante esse processo, os textos são divididos em #emph[tokens], que representam palavras completas ou fragmentos de palavras. Esses #emph[tokens], são convertidos em representações numéricas de alta dimensão, permitindo que o modelo analise matematicamente relações de proximidade e contexto entre diferentes elementos linguísticos.

Com base nessas relações estatísticas, os modelos conseguem calcular a probabilidade de um #emph[token], suceder outro dentro de uma sequência textual. Esse processo permite que #abbrev("LLMs") realizem tarefas como geração de texto, tradução automática, sumarização, interpretação contextual e respostas baseadas em linguagem natural. Quanto maior o volume de dados e a quantidade de parâmetros utilizados durante o treinamento, maior tende a ser a capacidade do modelo em compreender contextos complexos e produzir respostas coerentes #cite("brown2020").

=== Engenharia de Prompt

Para se comunicar com #abbrev("LLMs"), é necessário fornecer instruções textuais conhecidas como #emph[prompts]. Segundo #prose("openAIPromptGuide"), prompts consistem em instruções textuais utilizadas para orientar o comportamento do modelo durante a geração de respostas. Essas instruções podem incluir contexto adicional, regras de comportamento, exemplos de entrada e saída, restrições de formato e descrições detalhadas sobre a tarefa desejada. Quanto mais claro e contextualizado for o #emph[prompt], maior tende a ser a capacidade do modelo em produzir resultados coerentes com o objetivo esperado.

Essa interpretação contextual desempenha papel fundamental no funcionamento dos #abbrev("LLMs"). Palavras isoladas podem possuir múltiplos significados dependendo do contexto em que aparecem. O termo banco, por exemplo, pode se referir tanto a uma instituição financeira quanto a um objeto utilizado para sentar. Nesse cenário, os modelos utilizam relações estatísticas aprendidas durante o treinamento para analisar palavras vizinhas, estruturas semânticas e padrões linguísticos capazes de indicar qual significado possui maior probabilidade dentro daquele contexto específico #cite("openAIPromptGuide"). Dessa forma, a maneira como as informações são apresentadas no #emph[prompt], influencia diretamente a interpretação realizada pelo modelo.

Para orientar essa interpretação, diferentes técnicas de engenharia de #emph[prompt], podem ser empregadas. Entre elas estão o #emph[zero-shot], no qual o modelo executa uma tarefa apenas com base na instrução fornecida; o #emph[few-shot] que apresenta exemplos de entrada e saída para demonstrar o comportamento esperado; e o #emph[chain-of-thought] que orienta a decomposição de problemas complexos em etapas intermediárias de raciocínio. Por exemplo, para classificar uma emergência, o #emph[prompt], pode apenas solicitar a classificação (#emph[zero-shot]), apresentar relatos previamente classificados (#emph[few-shot]) ou solicitar que os elementos da ocorrência sejam analisados antes da resposta final (#emph[chain-of-thought]) #cite("wei2022").

Embora essas técnicas contribuam para orientar o modelo e tornar suas respostas mais previsíveis, elas não eliminam as limitações inerentes aos #abbrev("LLMs"). Pequenas alterações na estrutura textual da instrução podem gerar respostas significativamente diferentes, especialmente em tarefas complexas ou ambíguas. Além disso, modelos de linguagem podem produzir informações incorretas, fenômeno frequentemente chamado de  #emph[hallucination] no qual o sistema gera conteúdos sintaticamente coerentes, porém factualmente incorretos ou inexistentes  #cite("openAIPromptGuide").

Devido a essas características, a construção de prompts tornou-se uma etapa essencial no desenvolvimento de aplicações baseadas em inteligência artificial generativa. Estratégias como definição explícita de contexto, utilização de exemplos, delimitação de regras e restrição de formato são frequentemente utilizadas para aumentar a previsibilidade das respostas produzidas pelos modelos #cite("openAIPromptGuide").

== Modelos Multimodais

A evolução dos modelos de linguagem de grande porte também possibilitou o desenvolvimento dos chamados modelos multimodais, sistemas de inteligência artificial capazes de processar e interpretar múltiplos tipos de dados simultaneamente. Diferentemente de modelos tradicionais voltados exclusivamente para uma única modalidade de entrada, esses sistemas são treinados utilizando diferentes formas de informação, como linguagem natural, imagens, áudio e vídeo  #cite("openAIGPT4").

Tais modelos possuem a capacidade de integrar diferentes modalidades em uma mesma representação contextual, permitindo compreender relações entre informações textuais, visuais e sonoras presentes nos dados analisados. Como resultado, essa abordagem amplia significativamente a capacidade interpretativa da inteligência artificial, tornando possível a execução de tarefas mais complexas que envolvem múltiplos formatos de informação #cite("openAIGPT4").

Segundo #prose("openAIGPT4"),  o funcionamento desses modelos geralmente ocorre através da conversão das diferentes modalidades em representações numéricas compatíveis dentro do espaço vetorial utilizado pela rede neural. Dessa forma, textos, imagens, sons e vídeos podem ser processados conjuntamente pelo modelo, permitindo que relações contextuais entre diferentes tipos de informação sejam identificadas durante a inferência.

A utilização de arquiteturas multimodais tornou-se especialmente relevante em aplicações modernas relacionadas à análise de imagens, reconhecimento de fala, interpretação audiovisual e assistentes inteligentes capazes de compreender diferentes formatos de entrada simultaneamente. Além disso, esses modelos passaram a demonstrar capacidade de realizar tarefas cruzadas entre modalidades, como descrever imagens em linguagem natural, responder perguntas sobre conteúdos visuais e interpretar informações sonoras contextualizadas  #cite("openAIGPT4").

=== Processamento de Imagem

Diferente de #abbrev("LLMs") tradicionais voltadas exclusivamente para linguagem natural, os modelos multimodais possuem a capacidade de interpretar conteúdos visuais e relacioná-los ao contexto textual fornecido pelo usuário. Essa capacidade ampliou significativamente o potencial de aplicações baseadas em inteligência artificial, especialmente em cenários nos quais informações visuais desempenham papel importante para compreensão da situação analisada. Modelos multimodais modernos conseguem identificar objetos, interpretar cenas, reconhecer padrões visuais e responder perguntas relacionadas ao conteúdo presente em imagens, permitindo que informações textuais e visuais sejam analisadas conjuntamente durante a inferência  #cite("openAIGPT4").

Segundo #prose("openAIGPT4"), o funcionamento do processamento visual nesses modelos ocorre através da conversão dos elementos presentes na imagem em representações numéricas compatíveis com o espaço vetorial utilizado pela rede neural. Durante esse processo, características como formas, cores, texturas, objetos e relações espaciais são transformadas em #emph[embeddings] (representações vetoriais que preservam informações semânticas e estruturais dos dados) capazes de serem interpretados juntamente com dados textuais e contextuais. Dessa forma, o modelo consegue estabelecer relações semânticas entre diferentes modalidades de entrada, permitindo interpretação contextual integrada entre imagem e linguagem natural.

O processamento de imagens em modelos multimodais possui forte relação com técnicas de visão computacional #abbrev("RNNs")  anteriormente citados no documento. Segundo #prose("goodfellow2016"), arquiteturas convolucionais foram desenvolvidas especificamente para identificar padrões visuais em imagens através da aplicação sucessiva de filtros matemáticos capazes de reconhecer características progressivamente mais complexas. Em camadas iniciais, o modelo pode identificar bordas, linhas e texturas simples, enquanto camadas mais profundas conseguem reconhecer objetos completos, estruturas e relações contextuais presentes na cena analisada.

Embora modelos multimodais modernos não dependam exclusivamente de #abbrev("CNNs") tradicionais, muitas arquiteturas atuais ainda utilizam princípios derivados do aprendizado profundo aplicado à visão computacional para interpretar informações visuais. Em sistemas baseados em #emph[Transformers] multimodais, por exemplo, imagens podem ser divididas em pequenas regiões chamadas #emph[patches], que são convertidas em tokens visuais semelhantes aos tokens textuais utilizados em modelos de linguagem natural. Dessa forma, o modelo consegue aplicar mecanismos de atenção contextual também sobre elementos visuais da imagem #cite("dosovitskiy2021").

=== Processamento de Áudio

O processamento de áudio em modelos multimodais permite que sistemas de inteligência artificial interpretem informações sonoras e relacionem esses dados ao contexto textual e visual fornecido durante a inferência. Essa capacidade tornou-se especialmente relevante em aplicações modernas envolvendo reconhecimento de fala, assistentes virtuais, transcrição automática e interpretação contextual de sons presentes no ambiente analisado.

Diferente do processamento de imagens, no qual os elementos visuais podem ser examinados de forma espacial, o áudio é composto por informações distribuídas sequencialmente ao longo do tempo. Por esse motivo, modelos destinados à interpretação sonora precisam considerar tanto características individuais do sinal acústico quanto as dependências temporais existentes entre diferentes trechos da gravação. Segundo #prose("whisper2022"), sistemas modernos de processamento de áudio convertem sinais sonoros em representações numéricas adequadas ao processamento por redes neurais. Nesse procedimento, atributos como frequência, intensidade, duração e variações temporais são codificados em embeddings, possibilitando a associação dessas informações com outras modalidades presentes no sistema multimodal.

Grande parte das aplicações contemporâneas relacionadas à análise de áudio utiliza técnicas de reconhecimento automático de fala (#emph[Automatic Speech Recognition] – ASR), responsáveis por transformar a linguagem falada em texto para posterior interpretação pelos modelos de linguagem. Esses sistemas normalmente executam etapas como aquisição do sinal acústico, extração de características relevantes e decodificação da fala reconhecida #prose("whisper2022"). Embora frequentemente integrem soluções baseadas em #abbrev("LLMs"), mecanismos de ASR constituem componentes independentes e especializados, atuando como intermediários entre o conteúdo sonoro e os modelos responsáveis pela compreensão textual.

As primeiras aplicações modernas de reconhecimento de fala utilizaram fortemente arquiteturas recorrentes (#emph[Recurrent Neural Networks] – RNNs), anteriormente citadas neste documento. Segundo #prose("goodfellow2016"), essas redes são capazes de preservar informações provenientes de etapas anteriores do processamento, característica especialmente útil para a modelagem de sequências temporais presentes na fala humana.

=== Processamento de Vídeo

O processamento de vídeo em modelos multimodais envolve a análise simultânea de informações visuais e temporais, permitindo que sistemas de inteligência artificial compreendam eventos que se desenvolvem ao longo do tempo. Ao contrário de imagens estáticas, vídeos apresentam uma sequência contínua de quadros, exigindo que o modelo identifique não apenas os elementos presentes em cada cena, mas também as transformações e interações que ocorrem durante sua evolução temporal.

De modo geral, a análise de vídeos inicia-se pela decomposição do conteúdo audiovisual em múltiplos quadros de imagem, que podem ser processados individualmente por mecanismos semelhantes aos utilizados em tarefas de visão computacional. Segundo #prose("openAIGPT4"), as características extraídas desses quadros são convertidas em representações adequadas ao processamento neural, enquanto informações relacionadas à dinâmica temporal da sequência são utilizadas para identificar movimentos, ações e mudanças de contexto.

Além da dimensão visual, muitos sistemas multimodais também analisam o áudio associado ao vídeo. Essa integração permite correlacionar falas, ruídos e demais eventos acústicos com os elementos observados em cena, contribuindo para uma compreensão mais completa do conteúdo. Em diversos cenários, a combinação dessas modalidades fornece informações que não poderiam ser obtidas por meio da análise isolada de apenas uma delas #prose("openAIGPT4").

Arquiteturas modernas baseadas em #emph[Transformers] multimodais demonstraram elevado desempenho nesse domínio devido à capacidade de aplicar mecanismos de atenção sobre diferentes regiões espaciais e instantes temporais da sequência audiovisual. Como consequência, o modelo consegue relacionar objetos, ações, diálogos e acontecimentos distribuídos ao longo do vídeo, favorecendo uma compreensão contextual mais abrangente #prose("vaswani2017").

// ========== METODOLOGIA ==========
= Metodologia

Este trabalho apresenta uma pesquisa aplicada, de caráter exploratório, voltada ao desenvolvimento e à avaliação de uma prova de conceito. A análise combina medidas quantitativas de tempo, custo e consumo de tokens com a avaliação qualitativa da interpretação das ocorrências e das recomendações produzidas.

A metodologia utilizada neste trabalho consiste na análise de requisitos para o desenvolvimento de uma prova de conceito funcional de um sistema inteligente voltado ao auxílio no redirecionamento de solicitações emergenciais. A proposta envolve a construção de uma aplicação móvel integrada a um servidor responsável pelo recebimento, processamento e encaminhamento contextual das informações enviadas pelo usuário. O sistema foi estruturado utilizando arquitetura cliente-servidor, permitindo separar as responsabilidades relacionadas à interface da aplicação, processamento das requisições e integração com modelos de inteligência artificial. 

== Critérios de Escolha para o(s) Modelo(s) LLM

O funcionamento da proposta apresentada neste trabalho depende diretamente da integração entre o servidor #emph[backend] e modelos de inteligência artificial responsáveis pela interpretação contextual das solicitações enviadas pelos usuários. Dessa forma, tornou-se necessário analisar diferentes modelos de linguagem de grande porte capazes de processar informações multimodais e fornecer respostas contextualizadas adequadas ao cenário emergencial proposto pelo sistema Centro de Ajuda.

Considerando as necessidades da aplicação, foram definidos critérios técnicos para a seleção dos modelos avaliados. O primeiro critério foi a capacidade de processamento de diferentes modalidades de entrada, incluindo texto, áudio e imagem. Essa característica é necessária porque o sistema foi projetado para permitir que o usuário relate uma ocorrência utilizando diferentes formas de comunicação, conforme a situação enfrentada. Em um cenário de emergência, por exemplo, um usuário pode enviar apenas uma fotografia do local, um áudio descrevendo os acontecimentos ou uma mensagem textual, tornando indispensável que o modelo seja capaz de interpretar qualquer uma dessas modalidades.

Outro critério analisado foi a disponibilidade de utilização em infraestrutura de nuvem. Essa característica foi considerada devido às limitações técnicas associadas à execução local de modelos de linguagem de grande porte. Modelos multimodais modernos demandam elevada capacidade computacional, grande quantidade de memória e, em muitos casos, aceleradores gráficos especializados, recursos que normalmente não estão disponíveis em computadores pessoais convencionais. Dessa forma, a disponibilização dos modelos por meio de #abbrev("APIs", long: "Application Programming Interfaces") em nuvem permite que todo o processamento seja realizado em infraestrutura especializada, tornando sua utilização viável na aplicação proposta sem exigir #emph[hardware] de alto desempenho no servidor ou nos dispositivos dos usuários. 

Também foi avaliada a capacidade de realização de pesquisas na internet. Embora a interpretação inicial das ocorrências seja baseada nas informações fornecidas pelo usuário, determinadas situações podem exigir a consulta de informações atualizadas durante o processamento da solicitação. Serviços de atendimento, unidades de saúde e demais recursos de apoio podem sofrer alterações temporárias de funcionamento, indisponibilidade, mudanças de endereço, contatos ou outras condições que não estão necessariamente presentes na base de conhecimento do modelo. Dessa forma, a capacidade de realizar pesquisas na internet permite complementar a resposta com informações mais recentes e potencialmente mais adequadas ao contexto da ocorrência. 

Entre os modelos analisados destacam-se:

+ GPT-5.5, desenvolvido pela OpenAI; 
+ Claude Opus 4.8, desenvolvido pela Anthropic; 
+ Gemini 3.5 Flash, desenvolvido pela Google; 
+ Llama 4 Maverick, disponibilizado pela Meta; 
+ Qwen 3.6 Plus, desenvolvido pela Alibaba Cloud; 
+ Nemotron 3 Nano Omni 30B, desenvolvido pela NVIDIA; 
+ North Mini Code, desenvolvido pela Cohere. 

As informações apresentadas e as comparações entre os modelos correspondem à análise realizada em 10 de junho de 2026.

A seleção inicial desses modelos ocorreu devido à relevância no cenário atual da inteligência artificial generativa, ao suporte parcial ou completo às funcionalidades exigidas pelo projeto e à disponibilidade de integração por meio de #abbrev("APIs") comerciais compatíveis com aplicações executadas em nuvem. Nem todos os modelos avaliados atenderam integralmente aos critérios técnicos estabelecidos para a proposta desenvolvida neste trabalho, porém foram testados individualmente e suas comparações serão apresentadas para a justificativa do modelo considerado mais apto a ser utilizado.

A partir dos critérios estabelecidos, foi elaborada uma comparação preliminar com base nas fontes citadas nas subseções de cada modelo. A tabela sintetiza as modalidades descritas nessas fontes, a disponibilidade em nuvem e a forma de integração com pesquisa na internet. Trata-se de uma análise documental, distinta dos resultados das requisições realizadas no benchmark.

#tabela(
  caption: [Comparação de modelos quanto aos critérios técnicos],
  columns: (2fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  align: center,
  header: ([Critério], [GPT], [Claude], [Llama], [Qwen], [Gemini], [Nemotron], [North]),
  [Multimodal], [Parcial], [Parcial], [Parcial], [Parcial], [Sim], [Sim], [Não],
  [Nuvem], [Sim], [Sim], [Sim], [Sim], [Sim], [Sim], [Sim],
  [Busca: integração], [Plataforma], [Plataforma], [Externa], [Externa], [Plataforma], [Externa], [Externa],
) <tab:criterios-llm>

Na @tab:criterios-llm, a multimodalidade considera o conjunto de texto, imagem e áudio: “Sim” indica suporte descrito para as três modalidades, “Parcial” indica cobertura incompleta e “Não” indica apenas entrada textual. Por isso, o Nemotron recebe “Sim” na comparação documental, embora apresente falha de compreensão sonora nos experimentos. Em nuvem, “Sim” indica uma forma de acesso remoto. Para busca, “Plataforma” indica recursos oferecidos no ambiente do fabricante e “Externa” indica dependência de uma ferramenta integrada pela aplicação. Nenhuma dessas categorias comprova que uma consulta à internet tenha sido executada no benchmark. As subseções seguintes identificam as fontes e as particularidades de cada alternativa.

=== GPT-5.5

O GPT-5.5, desenvolvido pela OpenAI, foi selecionado para análise devido à sua relevância no cenário atual da inteligência artificial generativa. A avaliação do modelo foi realizada com base nos critérios técnicos definidos para a seleção das #abbrev("LLMs") utilizadas na proposta deste trabalho. #cite("gpt55")

Em relação ao critério de capacidade de processamento de diferentes modalidades de entrada, o GPT-5.5 oferece suporte ao processamento de texto, imagens e áudio por meio dos serviços disponibilizados pela plataforma da OpenAI, permitindo que aplicações interpretem diferentes modalidades de entrada de acordo com a forma como as informações são fornecidas pelo usuário. #cite("gpt55")

Quanto ao suporte à interpretação multimodal, o GPT-5.5 apresenta recursos para processamento de diferentes modalidades de entrada por meio da plataforma da OpenAI. Entretanto, sua #abbrev("API", long: "Application Programming Interface") não disponibiliza, de forma nativa, o envio simultâneo de texto, imagem e áudio em uma única solicitação, exigindo a utilização de recursos complementares da plataforma para integrar essas modalidades. Dessa forma, o modelo atende parcialmente ao critério de multimodalidade definido para este trabalho. #cite("gpt55") 

Em relação à infraestrutura, o GPT-5.5 é disponibilizado por meio de #abbrev("APIs") em nuvem oferecidas pela OpenAI, podendo também ser acessado por plataformas intermediárias. Essa abordagem dispensa a execução local do modelo e permite sua utilização em aplicações que não dispõem de hardware especializado para inferência de modelos de grande porte. #cite("gpt55") 

Por fim, o GPT-5.5 oferece suporte à realização de pesquisas na internet por meio de funcionalidades de acesso à web disponibilizadas pela OpenAI, permitindo complementar seu conhecimento com informações atualizadas quando necessário. Essa capacidade atende ao critério estabelecido para o sistema proposto. #cite("gpt55")

=== Claude Opus 4.8

Desenvolvido pela Anthropic, o Claude Opus 4.8 foi incluído na análise por representar uma das principais famílias de modelos de linguagem disponíveis comercialmente. Sua avaliação considerou os critérios técnicos estabelecidos para verificar sua adequação à proposta do sistema Centro de Ajuda. #cite("claude48")

Segundo #prose("claude48"), o Claude Opus 4.8 aceita como entrada informações textuais e imagens, além de documentos compatíveis com essas modalidades. Entretanto, o modelo não disponibiliza processamento nativo de áudio como entrada em sua #abbrev("API"), fazendo com que atenda apenas parcialmente ao critério de suporte às modalidades de entrada adotado neste trabalho.

No que se refere à interpretação multimodal, o modelo consegue combinar informações provenientes de texto e imagem durante uma mesma interação, produzindo respostas contextualizadas a partir dessas entradas. Contudo, a ausência de suporte nativo ao processamento simultâneo de áudio limita sua capacidade de atender integralmente ao requisito de multimodalidade definido para a proposta. #cite("claude48")

A documentação da Anthropic informa que o Claude Opus 4.8 também é disponibilizado por meio de #abbrev("APIs") executadas em infraestrutura de nuvem, podendo ser  facilmente integrado à aplicação, tornando sua utilização compatível com a arquitetura adotada neste trabalho. #cite("claude48")

Por fim, a plataforma Claude disponibiliza recursos de pesquisa na internet, permitindo que o modelo consulte informações externas durante a geração das respostas quando essa funcionalidade é utilizada pela aplicação. Dessa forma, o modelo atende ao critério relacionado ao acesso a informações atualizadas estabelecido nesta pesquisa. #cite("claude48")

=== Llama 4 Maverick

O Llama 4 Maverick, desenvolvido pela Meta, foi incluído na análise por integrar uma das principais famílias de modelos de linguagem com pesos abertos disponíveis atualmente. Sua avaliação foi conduzida considerando os critérios técnicos definidos para verificar sua adequação aos requisitos do sistema Centro de Ajuda. #cite("llama4maverick")

De acordo com #prose("llama4maverick"), o Llama 4 Maverick oferece suporte ao processamento de texto e imagens como modalidades de entrada. Entretanto, a documentação do modelo não prevê processamento nativo de áudio, fazendo com que o atendimento ao critério de suporte às modalidades de entrada seja parcial em relação às necessidades estabelecidas neste trabalho.

Em relação à interpretação multimodal, o modelo permite analisar conjuntamente informações textuais e visuais, utilizando essas modalidades para produzir respostas contextualizadas. Apesar dessa capacidade, a ausência de suporte nativo ao processamento simultâneo de áudio impede que o modelo atenda integralmente ao requisito de multimodalidade adotado como critério de seleção. #cite("llama4maverick")

A Meta disponibiliza o Llama 4 Maverick para utilização em infraestrutura de nuvem por meio de provedores e #abbrev("APIs") compatíveis, além de permitir sua integração com plataformas de distribuição de IAs. Por sua utilização não depender da execução local do modelo, sua adoção é compatível com a arquitetura cliente-servidor proposta neste trabalho. #cite("llama4api")

Quanto ao critério relacionado à pesquisa na internet, o Llama 4 Maverick pode ser integrado a ferramentas externas de busca e recuperação de informações, possibilitando que aplicações obtenham dados atualizados durante o processamento das solicitações. Essa funcionalidade depende da integração realizada pela aplicação, não sendo uma capacidade nativa do modelo. #cite("llama4maverick")

=== Qwen 3.6 Plus

O Qwen 3.6 Plus, desenvolvido pela Alibaba Cloud, foi incluído nesta análise por representar uma das principais soluções proprietárias da família Qwen. Sua avaliação teve como objetivo verificar o atendimento aos critérios técnicos definidos para a seleção das #abbrev("LLMs") empregadas no sistema Centro de Ajuda. #cite("qwenAPI")

Segundo #prose("qwenAPI"), o Qwen 3.6 Plus disponibiliza processamento nativo de texto e imagens, além de recursos voltados à compreensão de documentos e conteúdo visual. Entretanto, o modelo não oferece processamento nativo de áudio como modalidade de entrada, atendendo apenas parcialmente ao critério relacionado às modalidades de entrada estabelecido neste trabalho.

No que diz respeito à interpretação multimodal, o modelo foi projetado para correlacionar informações provenientes de texto e imagens durante uma mesma interação, permitindo análises contextuais integradas dessas modalidades. Apesar desse suporte, a ausência de processamento nativo de áudio impede que o requisito de multimodalidade definido para a proposta seja atendido integralmente. #cite("qwenVL")

A utilização do Qwen 3.6 Plus ocorre por meio da infraestrutura em nuvem disponibilizada pela Alibaba Cloud, sendo acessível por #abbrev("APIs") compatíveis com diferentes padrões de integração. Essa característica elimina a necessidade de execução local do modelo e favorece sua adoção em arquiteturas cliente-servidor semelhantes à utilizada neste trabalho. #cite("qwenAPI")

Quanto ao critério de pesquisa na internet, o ecossistema Qwen permite a integração do modelo com ferramentas externas e recursos de busca durante a execução de tarefas, possibilitando a obtenção de informações atualizadas quando configurado para esse tipo de operação. Dessa forma, o modelo atende ao critério definido para esta pesquisa. #cite("qwenAPI")

=== Gemini 3.5 Flash

O Gemini 3.5 Flash, desenvolvido pela Google, foi selecionado para análise em razão de sua relevância entre os modelos multimodais atuais e da disponibilidade de acesso por meio de #abbrev("APIs") compatíveis com a proposta deste trabalho. Sua avaliação foi conduzida considerando os critérios técnicos estabelecidos para a seleção das #abbrev("LLMs") empregadas no sistema Centro de Ajuda. #cite("gemini35flash")
Segundo #prose("gemini35flash"), o Gemini 3.5 Flash oferece suporte nativo ao processamento de texto, imagens, áudio, vídeo e documentos, permitindo que diferentes modalidades de entrada sejam utilizadas durante uma mesma interação. Dessa forma, o modelo atende integralmente ao critério relacionado ao processamento das modalidades de entrada adotado nesta pesquisa.

No que se refere à interpretação multimodal, o Gemini 3.5 Flash foi projetado para correlacionar simultaneamente informações provenientes das modalidades suportadas, possibilitando uma compreensão contextual unificada das entradas recebidas. Essa característica atende integralmente ao requisito de multimodalidade definido para o sistema proposto. #cite("gemini35flash")

Além dos modelos anteriores, a documentação da Google também informa que o Gemini 3.5 Flash é disponibilizado por meio de #abbrev("APIs") executadas em infraestrutura de nuvem e está disponível em plataformas intermediárias. \cite#cite("geminiAPI")

Além disso, o Gemini 3.5 Flash disponibiliza recursos nativos de pesquisa na internet por meio das ferramentas da plataforma Gemini, permitindo consultar informações atualizadas durante o processamento das solicitações. Essa funcionalidade atende ao critério de acesso a informações externas estabelecido para a avaliação dos modelos. #cite("gemini35flash")

=== Nemotron 3 Nano Omni

O Nemotron 3 Nano Omni 30B A3B Reasoning, desenvolvido pela NVIDIA, foi incluído na análise por representar um modelo multimodal voltado a aplicações que exigem raciocínio sobre diferentes tipos de dados. Sua avaliação foi realizada considerando os critérios técnicos definidos para a seleção das #abbrev("LLMs") empregadas na proposta do sistema Centro de Ajuda. #cite("nemotron3nano")

Conforme a documentação oficial da NVIDIA, o modelo aceita como entrada texto, imagens, áudio e vídeo, permitindo que diferentes modalidades sejam utilizadas durante uma mesma interação. Dessa forma, o Nemotron 3 Nano Omni atende integralmente ao critério relacionado ao processamento de diferentes modalidades de entrada adotado nesta pesquisa. #cite("nemotron3nano")

Em relação ao suporte à interpretação multimodal, o modelo foi projetado para realizar raciocínio conjunto sobre informações provenientes das modalidades suportadas em um único processo de inferência. Essa característica permite correlacionar simultaneamente diferentes fontes de informação, atendendo ao requisito de multimodalidade estabelecido para o sistema proposto. #cite("nemotron3nano")

A NVIDIA disponibiliza o Nemotron 3 Nano Omni por meio de serviços executados em infraestrutura de nuvem, incluindo #abbrev("APIs") NVIDIA NIM e provedores parceiros. Essa abordagem possibilita sua integração à arquitetura cliente-servidor adotada neste trabalho sem exigir a execução local do modelo. #cite("nemotron3nano")

Quanto ao critério de pesquisa na internet, o Nemotron 3 Nano Omni não disponibiliza um mecanismo nativo de consulta à web. Entretanto, sua arquitetura permite integração com ferramentas externas responsáveis pela recuperação de informações atualizadas durante a execução da aplicação, possibilitando o atendimento deste requisito quando tais recursos são incorporados ao sistema. #cite("nemotron3nano")

=== North Mini Code

O North Mini Code, desenvolvido pela Cohere, participou desta análise por ocupar espaço como um modelo de peso, voltado à geração de código e à execução de tarefas de engenharia de software por agentes. O modelo utiliza uma arquitetura #emph[Mixture of Experts], com 30 bilhões de parâmetros totais e 3 bilhões ativos durante a inferência. Sua avaliação foi realizada considerando os critérios técnicos definidos para verificar sua adequação à proposta do sistema Centro de Ajuda. #cite("northMiniCode")

Sobre às modalidades de entrada, o North Mini Code foi desenvolvido essencialmente para o processamento de texto e código. A documentação não indica suporte nativo à utilização de imagens ou áudio como entrada, infelizmente fazendo com que este modelo atende apenas ao processamento textual entre as modalidades adotadas neste trabalho. #cite("northMiniCode")

Quanto a sua interpretação multimodal, a ausência de suporte nativo a imagens e áudio impede que o modelo correlacione essas informações com o conteúdo textual em uma mesma solicitação. Dessa forma, embora consiga interpretar relatos fornecidos em texto, o North Mini Code não atende ao requisito de multimodalidade estabelecido para o sistema proposto. #cite("northMiniCode")

O modelo é disponibilizado sob a licença Apache 2.0 e pode ser executado localmente, devido à quantidade reduzida de parâmetros ativos, ou acessado por serviços em nuvem oferecidos pela Cohere e por plataformas intermediárias. #cite("northMiniCode")

Quanto ao critério de pesquisa na internet, o North Mini Code não possui um mecanismo nativo de consulta à web. Entretanto, seu suporte ao uso de ferramentas permite que seja integrado a mecanismos externos de busca e recuperação de informações. Assim, o atendimento a esse critério depende dos recursos fornecidos pela aplicação, não constituindo uma capacidade nativa do modelo. #cite("northMiniCode")

== Requisitos do Frontend

O #emph[frontend] corresponde à camada da aplicação responsável pela interação direta com o usuário. Em sistemas baseados em arquitetura cliente-servidor, essa camada tem como função apresentar informações, coletar dados de entrada e encaminhar solicitações aos serviços disponibilizados pelo servidor. No contexto deste trabalho, o #emph[frontend] é responsável por permitir que o usuário registre uma ocorrência emergencial por meio de texto, áudio ou imagem, além de disponibilizar os resultados retornados pelo sistema de classificação inteligente. 

=== Infraestrutura Frontend

A infraestrutura #emph[frontend] da aplicação foi definida considerando os elementos necessários para o funcionamento da prova de conceito. Para que o usuário possa registrar uma ocorrência, enviar as informações ao sistema e visualizar o resultado da classificação, foram identificadas três áreas fundamentais: interface do usuário, compatibilidade multiplataforma e comunicação cliente-servidor.

A interface do usuário é responsável pela apresentação visual da aplicação e pela coleta das informações fornecidas pelo usuário. A compatibilidade multiplataforma possibilita o acesso à aplicação em diferentes dispositivos e sistemas operacionais. Já a comunicação cliente-servidor realiza a troca de informações entre o #emph[frontend] e os serviços executados no #emph[backend], permitindo o envio dos dados coletados e o recebimento dos resultados gerados pelo sistema.

=== Interface do Usuário

A construção da interface da aplicação foi realizada utilizando HTML, CSS e JavaScript, tecnologias consolidadas como padrão para o desenvolvimento de aplicações web. Sua adoção ocorreu devido à ampla compatibilidade entre navegadores, à extensa documentação disponível, ao ecossistema consolidado de ferramentas e à possibilidade de reutilização do código em soluções híbridas para dispositivos móveis, reduzindo o esforço de desenvolvimento e manutenção da aplicação.

Nesse contexto, o HTML foi empregado para estruturar semanticamente a interface, o CSS para definir sua apresentação visual e adaptação a diferentes tamanhos de tela, enquanto o JavaScript foi utilizado para implementar a lógica da aplicação, gerenciar eventos, manipular dinamicamente os elementos da interface e realizar a comunicação com os serviços disponibilizados pelo #emph[backend].

=== Compatibilidade Multiplataforma

A compatibilidade multiplataforma da aplicação é proporcionada pela utilização de tecnologias web, permitindo que a interface seja acessada em diferentes dispositivos e sistemas operacionais por meio de navegadores compatíveis. Essa abordagem evita a necessidade de desenvolver uma versão específica da aplicação para cada plataforma.

Além disso, a aplicação pode ser disponibilizada como uma #abbrev("PWA", long: "Progressive Web App"). Uma #abbrev("PWA") consiste em uma aplicação web que incorpora características de aplicações instaláveis, podendo ser adicionada à tela inicial do dispositivo e executada em uma janela própria. Sua configuração básica utiliza recursos como um arquivo de manifesto, responsável por definir informações como nome, ícone e aparência da aplicação, e um #emph[Service Worker], que pode gerenciar o armazenamento de recursos e determinadas funcionalidades em segundo plano.

Essa abordagem mostrou-se adequada à prova de conceito por permitir sua utilização em computadores e dispositivos móveis sem depender de tecnologias de empacotamento nativo, preservando uma única base de código desenvolvida com HTML, CSS e JavaScript.

=== Comunicação Cliente-Servidor

A comunicação entre #emph[frontend] e #emph[backend] foi implementada utilizando a #abbrev("API") Fetch, interface nativa disponibilizada pelos navegadores modernos para a realização de requisições HTTP assíncronas. Conforme apresentado em @fig:fetch-api, ao executar a função fetch(), a aplicação inicia a requisição HTTP e recebe imediatamente uma Promise, inicialmente em estado pendente. Enquanto a requisição é processada, a execução da interface permanece disponível, sem precisar aguardar de forma bloqueante pela resposta do servidor. Quando a comunicação é concluída com sucesso, a Promise é resolvida, permitindo o acesso à resposta e às informações retornadas pelo #emph[backend]. Caso ocorra uma falha que impeça a conclusão da requisição, a Promise é rejeitada, possibilitando que a aplicação identifique e trate o erro. Dessa forma, o uso da #abbrev("APIs") Fetch contribui para uma experiência de utilização mais fluida e responsiva.

#figura(
  image("assets/imagens/fetch-api.png", width: 80%),
  caption: [Fluxo da API Fetch com Promise],
) <fig:fetch-api>

Nesse contexto, a #abbrev("API") Fetch é responsável pelo envio das informações fornecidas pelo usuário, incluindo dados textuais, arquivos multimídia e informações contextuais, bem como pelo recebimento das respostas geradas pelos serviços de processamento executados no #emph[backend].

== Requisitos do Backend

O #emph[backend] concentra o processamento necessário para transformar os dados enviados pelo usuário em uma resposta utilizável pela aplicação. Para viabilizar a prova de conceito do sistema Centro de Ajuda, essa camada precisava cumprir quatro funções principais: receber solicitações contendo diferentes modalidades de entrada, complementar os dados com informações de localização, encaminhar o contexto da ocorrência ao modelo de linguagem e devolver ao #emph[frontend] uma resposta estruturada. 

A centralização dessas operações no servidor evita que a aplicação cliente precise conhecer os serviços externos utilizados ou armazenar credenciais de acesso às #abbrev("APIs"). Dessa forma, o #emph[frontend] permanece responsável apenas pela coleta e apresentação das informações, enquanto validações, integrações e regras relacionadas à classificação das ocorrências são executadas no #emph[backend]. 

=== Infraestrutura Backend

A infraestrutura foi construída como uma aplicação web executada em servidor e organizada em torno de uma rota principal de atendimento. Essa rota recebe o relato do usuário, valida os dados enviados e coordena as etapas necessárias até a obtenção da classificação. Durante esse processo, o servidor comunica-se com o serviço de geolocalização, prepara o contexto utilizado na consulta ao modelo de linguagem e trata a resposta antes de devolvê-la à aplicação cliente. 

Para implementar esse fluxo, foram utilizados o Node.js como ambiente de execução, o Express para definição e controle das rotas HTTP e a #abbrev("API") Fetch para comunicação com os serviços externos. Cada uma dessas tecnologias exerce uma função específica na infraestrutura, permitindo separar o recebimento da solicitação, o processamento interno e as integrações realizadas pela aplicação. 

=== Ambiente de Execução

O #emph[backend] foi implementado em Node.js, possibilitando a utilização de JavaScript também no lado do servidor. Além da familiaridade prévia com a linguagem, sua adoção permitiu manter uma base tecnológica próxima à utilizada no #emph[frontend] e simplificar a manipulação das estruturas JSON trocadas entre as camadas da aplicação. 

O modelo assíncrono do Node.js foi especialmente relevante para a prova de conceito, pois parte significativa do tempo de processamento depende de serviços externos. Durante uma solicitação, o servidor pode aguardar a conversão das coordenadas geográficas e a resposta do modelo de linguagem sem bloquear completamente a execução de outras operações. Esse comportamento é adequado a uma aplicação cuja principal função consiste em coordenar requisições HTTP e organizar os resultados obtidos. 

Na implementação desenvolvida, o Node.js executa o servidor, recebe os dados encaminhados pelo #emph[frontend], controla a sequência de chamadas externas e prepara a resposta final da ocorrência. 

=== Estrutura da Aplicação

Sobre o ambiente Node.js, o Express foi utilizado para criar a interface HTTP do #emph[backend]. Sua função principal na aplicação é disponibilizar a rota responsável pelo recebimento das solicitações de ajuda e fornecer os mecanismos necessários para acessar o conteúdo enviado pelo #emph[frontend]. 

Quando uma requisição é recebida, o Express direciona os dados para a função responsável pelo processamento da ocorrência. Antes de prosseguir, são verificadas informações obrigatórias, como a presença e a validade das coordenadas geográficas. Em seguida, a solicitação percorre as etapas de obtenção da localização, construção dos prompts, consulta ao modelo de linguagem e tratamento da resposta retornada. 

A utilização do Express também permitiu manter o controle do fluxo HTTP em um ponto definido da aplicação. Assim, situações como dados inválidos, falhas nas #abbrev("APIs") externas ou respostas incompatíveis podem ser convertidas em respostas HTTP adequadas, evitando que erros internos sejam enviados diretamente ao #emph[frontend]. 

=== Integração com Serviços Externos

As chamadas realizadas pelo #emph[backend] foram implementadas com a #abbrev("API") Fetch, disponível nativamente nas versões modernas do Node.js. Diferentemente de sua utilização no #emph[frontend], onde é responsável por enviar a solicitação de ajuda, no servidor a Fetch estabelece a comunicação com as #abbrev("APIs") necessárias para complementar e analisar os dados recebidos. 

Uma dessas integrações ocorre com o serviço de geocodificação reversa do Google Maps. Por meio dele, as coordenadas de latitude e longitude são convertidas em informações textuais, como rua, bairro, cidade e estado. Essa conversão fornece ao modelo de linguagem um contexto de localização mais compreensível do que a utilização isolada dos valores numéricos. 

A Fetch também é utilizada para encaminhar à #abbrev("API") os prompts e as modalidades presentes na solicitação. A plataforma direciona o conteúdo ao modelo selecionado e retorna o resultado da análise ao #emph[backend]. Como ambas as operações dependem de serviços remotos, o uso de requisições assíncronas permite controlar cada etapa, verificar falhas de comunicação e impedir que uma resposta incompleta seja tratada como resultado válido. 

== Fluxo de Comunicação

O fluxo de comunicação inicia-se quando o #emph[frontend] envia uma solicitação contendo uma ou mais formas de relato, que podem incluir texto, áudio e imagem. Junto a esse conteúdo, são enviadas as coordenadas geográficas e as demais informações contextuais coletadas pela aplicação. 

Ao receber a requisição, o #emph[backend] verifica os dados necessários para o processamento. As coordenadas são encaminhadas à #abbrev("API") Google Maps para realização da geocodificação reversa, resultando em uma descrição textual da localização. Posteriormente, essa descrição é combinada com o horário da solicitação e com o relato fornecido pelo usuário para compor o contexto encaminhado ao modelo de linguagem. 

O conjunto formado pelos prompts, pela localização e pelas modalidades recebidas é enviado à plataforma de distribuição de IAs, que realiza a comunicação com o modelo selecionado. As #abbrev("LLMs") interpretam a ocorrência e retornam uma resposta com o serviço indicado, o número de contato e um resumo do contexto identificado. 

Antes de devolver o resultado ao #emph[frontend], o #emph[backend] verifica e organiza o conteúdo retornado, preservando somente os campos esperados pela aplicação. Após essa etapa, a resposta é enviada ao cliente, que apresenta ao usuário a classificação da ocorrência e as informações necessárias para o contato com o serviço indicado. 

Esse fluxo mantém as integrações externas e o processamento da ocorrência concentrados no #emph[backend], reduzindo o acoplamento do #emph[frontend] aos serviços utilizados. A sequência completa da comunicação entre o usuário, o #emph[frontend], e #emph[backend] e as #abbrev("APIs") externas pode ser observada na @fig:diagrama_metodologia_backend. 

//@fig:diagrama_metodologia_backend.

#figura(
  image("assets/imagens/fluxo-backend.png", width: 90%),
  caption: [Fluxo de comunicação entre frontend, backend e APIs externas],
) <fig:diagrama_metodologia_backend>

== Métodos de Avaliação e Análise <sec:metodos-avaliacao>

A avaliação combinou medidas quantitativas de execução com análise qualitativa das respostas. A unidade de análise foi cada combinação entre modelo e cenário. A aceitação da requisição, o conteúdo retornado, a estrutura JSON e os erros registrados foram examinados separadamente, evitando interpretar uma resposta formalmente válida como evidência suficiente de compreensão da ocorrência.

As classificações foram atribuídas neste trabalho a partir dos registros do #emph[benchmark], descritos no capítulo de resultados, e da comparação entre as entradas e as respostas apresentadas. Elas não correspondem a notas fornecidas pelos fabricantes, a um ranking externo ou a uma validação por especialistas. Para tornar essa análise verificável, foram adotadas as seguintes definições:

+ *Processamento da entrada:* “Sucesso” indica que a execução retornou uma resposta que reconheceu o conteúdo central do cenário; “Falha” indica erro de execução ou ausência dessa compreensão; “Sem resultado” identifica um registro vazio, cuja causa não pode ser determinada.
+ *Estrutura JSON:* “Completo” indica a presença dos campos `service_name`, `phone_number` e `emergency_context` nos quatro cenários; “Parcial” indica que a estrutura foi obtida apenas em parte deles. Esse critério não atesta a correção factual do conteúdo.
+ *Adequação da recomendação:* a análise verifica a correspondência entre o relato, o resumo e o serviço indicado, a presença de ambiguidades e a introdução de informações não sustentadas pela entrada. As ressalvas são descritas por modelo, sem converter essa avaliação exploratória em uma nota global.
+ *Tempo, custo e tokens:* foram considerados o tempo total observado pelo servidor e os valores disponíveis no retorno da integração. Esses indicadores descrevem as execuções registradas e não constituem médias ou estimativas de desempenho geral.

A interpretação esperada decorre dos elementos de cada cenário: veículo parado e insegurança no acostamento; árvore sobre a fiação e risco elétrico; animal atropelado; e entrada de água em uma residência. Esses elementos permitem verificar se o resumo corresponde à entrada, mas não estabelecem, por si só, um único serviço correto para todos os casos. A escolha de um órgão específico e a validade de um telefone local exigem verificação adicional.

A comparação das modalidades refere-se à combinação efetivamente enviada. Uma resposta coerente no cenário de texto e imagem não demonstra, isoladamente, quanto cada modalidade contribuiu para a interpretação, pois não foi descrito um experimento de remoção alternada das entradas.

== Procedimentos Experimentais

O procedimento experimental foi organizado nas seguintes etapas:

+ selecionar os sete modelos e preparar quatro cenários: texto, texto com imagem, áudio e áudio com imagem;
+ reunir os relatos, os arquivos correspondentes, as coordenadas e o horário de cada cenário;
+ complementar a localização por geocodificação reversa e construir as mensagens com as regras da tarefa, o contexto e a entrada do usuário;
+ submeter os mesmos cenários aos modelos por meio do OpenRouter, sem modelos auxiliares na comparação principal;
+ registrar a resposta ou o erro de cada execução, juntamente com as métricas disponíveis;
+ verificar a estrutura retornada e comparar seu conteúdo com o cenário, aplicando os critérios definidos em @sec:metodos-avaliacao.

A comparação principal abrange sete modelos e quatro cenários, totalizando 28 combinações previstas. Uma combinação sem resposta aproveitável permanece registrada como tal; não é convertida em sucesso nem excluída silenciosamente da análise.

Em uma etapa complementar, foram examinadas possibilidades de composição sequencial de modelos, nas quais um componente interpreta áudio ou imagem e encaminha uma representação textual ao classificador. Essa análise de viabilidade é apresentada separadamente, pois a disponibilidade de componentes não comprova o funcionamento, o custo ou a qualidade do fluxo completo.

== Limitações do Estudo

A avaliação utiliza quatro cenários e não apresenta uma série de repetições suficiente para estimar variabilidade, intervalos de confiança ou diferenças estatisticamente significativas. Os resultados são exploratórios e restritos aos modelos, rotas e condições de execução descritos. O tempo observado inclui comunicação e processamento remoto, e pode variar com a disponibilidade e a carga dos provedores.

Não foi estabelecido um conjunto de respostas de referência validado por profissionais de atendimento emergencial. A adequação foi examinada a partir do conteúdo dos cenários e das respostas, sem validação independente de todos os serviços e telefones locais. Assim, coerência textual e conformidade com o JSON não equivalem à segurança da recomendação para uso real.

Falhas de integração também limitam a interpretação dos resultados. Uma mensagem explícita de incompatibilidade permite identificar uma modalidade não aceita pela rota utilizada; um erro genérico ou um registro vazio não permite determinar a causa da falha nem concluir que a família inteira de modelos seja incapaz de processar aquela entrada.

O levantamento de recursos de pesquisa na internet e de modelos auxiliares não comprova que essas funcionalidades tenham sido acionadas com sucesso nas requisições avaliadas. A análise complementar dos ecossistemas não substitui testes completos das composições. Por fim, não foram demonstrados benefícios operacionais, redução do tempo de socorro ou validação da aplicação por usuários em emergências reais.

// ========== DESENVOLVIMENTO ==========
= Desenvolvimento

Neste capítulo são apresentados os detalhes de desenvolvimento do sistema Centro de Ajuda. São descritas as decisões de projeto, as tecnologias utilizadas, o funcionamento do aplicativo cliente e do servidor, a construção dos prompts enviados aos modelos de linguagem e o processo de avaliação por meio do #emph[benchmark]. O objetivo deste capítulo é fornecer uma visão completa de como a solução foi implementada e como os componentes interagem para entregar ao usuário a recomendação do serviço de emergência mais adequado à situação descrita.

== Abordagem Geral

O desenvolvimento do sistema foi dividido em duas camadas principais: a aplicação cliente, responsável pela interação com o usuário, e a aplicação servidora, encarregada do processamento das solicitações e da comunicação com os modelos de linguagem. Essa separação permite isolar as responsabilidades de cada componente, facilitando a manutenção, a evolução da arquitetura e a substituição de tecnologias sem impactar os demais módulos.

Nesta prova de conceito, o foco do desenvolvimento concentrou-se na implementação do #emph[backend] e na validação do fluxo completo de processamento das solicitações de emergência. A parte responsável pelo #emph[frontend] do cliente móvel foi representada por um protótipo funcional de interface elaborado no Figma, utilizado para definir o fluxo de interação do usuário e demonstrar o comportamento esperado da aplicação. Dessa forma, embora as telas e a arquitetura do cliente tenham sido projetadas, sua implementação completa não fez parte do escopo desta etapa do trabalho.

== Implementação da Aplicação Cliente

O desenvolvimento da aplicação cliente teve como principal objetivo fornecer uma interface simples, intuitiva e acessível para o registro de ocorrências de emergência. Considerando que o usuário pode estar em uma situação de estresse ou risco, buscou-se reduzir ao máximo a quantidade de interações necessárias para realizar uma solicitação.

A aplicação foi projetada para dispositivos móveis e organizada em módulos responsáveis pela interface com o usuário, captura das diferentes formas de entrada e envio das informações ao servidor. Dessa forma, cada componente possui uma responsabilidade específica, facilitando tanto a manutenção quanto futuras expansões da aplicação.

=== Arquitetura do Cliente

A arquitetura da aplicação cliente foi organizada de acordo com o fluxo de interação do usuário, abrangendo a coleta das informações, a preparação da solicitação, a comunicação com o servidor e a apresentação do resultado.

Inicialmente, a tela de entrada permite que o usuário registre o relato por texto, áudio ou imagem. A aplicação também obtém as informações adicionais necessárias para contextualizar a ocorrência, como a localização geográfica e o horário da solicitação. Os dados coletados são encaminhados ao módulo de comunicação, responsável por organizá-los e enviá-los ao #emph[backend].

Durante o processamento da solicitação pelo servidor, a aplicação apresenta uma tela de espera, que informa ao usuário que a ocorrência está sendo analisada. Após o recebimento da resposta, o fluxo é direcionado à tela de resultado, na qual são apresentados o serviço de emergência recomendado, o número de telefone correspondente, o resumo do contexto identificado e a opção de iniciar a ligação.

Conforme a @fig:diagrama_desenvolvimento_frontend_arquitetura, esses componentes foram organizados de maneira sequencial, acompanhando as etapas realizadas desde o registro da ocorrência até a apresentação da recomendação ao usuário.

#figura(
  image("assets/imagens/arquitetura-cliente.png", width: 90%),
  caption: [Arquitetura da aplicação cliente],
) <fig:diagrama_desenvolvimento_frontend_arquitetura>

=== Tecnologias da Aplicação Cliente

A interface da aplicação foi desenvolvida com tecnologias consolidadas no desenvolvimento web. O HTML5 foi utilizado na estruturação das telas, enquanto o CSS3 foi empregado na estilização dos componentes. O JavaScript foi responsável pelo gerenciamento das interações, pela captura dos dados, pelo controle da navegação entre as telas e pela comunicação com o servidor.

O framework Bootstrap foi utilizado para padronizar os elementos visuais e auxiliar na construção de uma interface responsiva, adequada às diferentes dimensões de tela dos dispositivos móveis.

A comunicação entre a aplicação cliente e o #emph[backend] foi implementada por meio da Fetch #abbrev("API"). Após a coleta das informações da ocorrência, o JavaScript organiza os dados e realiza uma requisição HTTP ao servidor. A resposta recebida é interpretada pelo cliente e utilizada para preencher a tela de resultado.

==== Implementação PWA

Com o objetivo de facilitar o acesso ao sistema em dispositivos móveis, a aplicação cliente foi implementada como uma #abbrev("PWA") básica. Essa abordagem permite que o sistema seja executado diretamente pelo navegador e adicionado à tela inicial do dispositivo, oferecendo uma experiência semelhante à de uma aplicação instalada, sem exigir seu empacotamento como aplicativo nativo.

A implementação da #abbrev("PWA") foi realizada por meio da inclusão de um arquivo de manifesto e de um #emph[Service Worker]. O arquivo manifest.json fornece ao navegador informações de identificação e apresentação da aplicação, como nome, ícones, cores, endereço inicial e modo de exibição. Entre suas configurações, a propriedade display, definida como standalone, permite que a aplicação seja executada em uma janela independente, sem os elementos convencionais de navegação do navegador. Os ícones especificados no manifesto são utilizados na tela inicial do dispositivo e em outros elementos de identificação da aplicação.

Complementarmente, o #emph[Service Worker] consiste em um script executado em segundo plano pelo navegador. Na aplicação desenvolvida, ele é responsável pelo armazenamento local dos arquivos essenciais da interface, possibilitando que esses recursos sejam recuperados sem a necessidade de serem baixados novamente a cada acesso. Em conjunto, o manifesto e o #emph[Service Worker] fornecem as funcionalidades necessárias para que a aplicação web apresenta características semelhantes às de uma aplicação instalada no dispositivo.

=== Tela Inicial

A tela inicial da aplicação concentra todas as funcionalidades necessárias para o registro da ocorrência, sendo projetada em um design minimalista para minimizar a quantidade de interações exigidas do usuário em uma situação de emergência. 

Conforme a @fig:diagrama_desenvolvimento_frontend_entrada apresenta, a interface adota um tema escuro com elementos de destaque em azul, priorizando contraste visual e facilidade de identificação das ações principais. Na parte superior da tela é apresentado o nome da aplicação, acompanhado de uma breve instrução orientando o usuário a descrever a ocorrência.

A região central da interface é composta por um campo destinado à descrição textual da emergência e por botões para captura de áudio e imagem, permitindo que diferentes tipos de informação sejam enviados ao sistema. Na parte inferior encontra-se o botão "Pedir Ajuda", responsável por iniciar o envio da solicitação ao servidor.

A organização desses elementos foi definida com o objetivo de reduzir a navegação entre telas e concentrar todos os recursos de entrada de dados em uma única interface, tornando o processo de solicitação mais rápido e intuitivo.

#figura(
  image("assets/imagens/tela-inicial.png", width: 70%),
  caption: [Tela inicial do Centro de Ajuda],
) <fig:diagrama_desenvolvimento_frontend_entrada>

==== Captura de texto

A entrada textual foi implementada por meio de um elemento HTML do tipo <textarea>, no qual o usuário pode descrever a ocorrência em linguagem natural. O componente permite a inserção de textos com múltiplas linhas e limita o relato a 2.000 caracteres, evitando o envio de conteúdos excessivamente longos. 

#codigo(
  lang: "html",
  caption: [Campo de texto da ocorrência],
  filename: "occurrence.html",
  read("assets/codigos/occurrence.html"),
) <code:textarea>

O campo não foi definido como obrigatório porque a aplicação também permite o envio de solicitações compostas apenas por áudio ou imagem. A verificação da presença de pelo menos uma forma de entrada é realizada posteriormente, antes do envio da solicitação.

Quando o usuário confirma o envio, o conteúdo do campo é acessado pelo JavaScript por meio da Document Object Model (DOM). O método document.getElementById() localiza o elemento a partir de seu identificador, enquanto a propriedade value recupera o texto inserido. Em seguida, o método trim() remove espaços em branco desnecessários do início e do final do relato.

#codigo(
  lang: "javascript",
  caption: [Captura de texto via DOM],
  filename: "capture.js",
  read("assets/codigos/capture.js"),
)

Quando o campo está vazio ou contém apenas espaços, a função retorna null. Caso exista conteúdo válido, o texto é retornado para posteriormente ser incorporado à solicitação encaminhada ao servidor. 

==== Captura de áudio

A captura de áudio foi implementada com a MediaDevices #abbrev("API"). Quando o usuário inicia a gravação, o método `navigator.mediaDevices.getUserMedia()` solicita autorização para acessar o microfone do dispositivo. Caso a permissão seja concedida, o navegador fornece um fluxo de mídia, representado por um objeto MediaStream, que é disponibilizado para a aplicação. 

#codigo(
  lang: "javascript",
  caption: [Solicitação de acesso ao microfone],
  filename: "audio.js",
  read("assets/codigos/audio.js"),
)

Caso o usuário recuse a permissão ou o dispositivo não possua um microfone disponível, a função retorna null, permitindo que a aplicação informe o erro sem interromper as demais formas de entrada.

A gravação é realizada por meio da MediaRecorder #abbrev("API"), que recebe o fluxo fornecido pelo microfone. Durante a gravação, os dados de áudio são disponibilizados em pequenos blocos, denominados #emph[chunks], e armazenados temporariamente em um vetor. Quando a gravação é encerrada, esses blocos são reunidos em um objeto #emph[blob], preservando o formato de áudio selecionado pelo navegador.

#codigo(
  lang: "javascript",
  caption: [Gravação de áudio com MediaRecorder],
  filename: "recorder.js",
  read("assets/codigos/recorder.js"),
)

O objeto audioBlob resultante permanece armazenado na aplicação até a confirmação do envio. Posteriormente, ele pode ser anexado diretamente à solicitação por meio da interface FormData, juntamente com as demais informações da ocorrência. 

==== Captura de imagens

A captura de imagens foi implementada com os recursos disponibilizados pelo próprio navegador, sem a utilização de plugins ou integração direta com código nativo. Para isso, foi utilizado um campo de seleção de arquivos configurado para aceitar somente imagens.

Esse campo de seleção possui o atributo `capture="environment"`, que indica ao navegador a preferência pelo uso da câmera traseira do dispositivo. Entretanto, seu comportamento pode variar de acordo com o navegador e o sistema operacional, que também podem permitir a escolha de uma imagem já armazenada no dispositivo.Após a captura ou seleção, o navegador disponibiliza a imagem como um objeto do tipo `File`. O JavaScript obtém esse arquivo por meio da propriedade files do campo de entrada e verifica se o conteúdo selecionado corresponde a uma imagem.

A #abbrev("API") `FileReader` é utilizada para gerar uma representação da imagem no formato `Data URI`, permitindo sua exibição na interface antes do envio. O arquivo original, contudo, permanece armazenado no objeto `imageFile` e será posteriormente anexado à solicitação por meio da interface `BodyParser`.

#codigo(
  lang: "javascript",
  caption: [Captura de imagem],
  filename: "image.js",
  read("assets/codigos/image.js"),
)

==== Envio da solicitação

Após a coleta das informações fornecidas pelo usuário, a aplicação reúne os dados da ocorrência em uma única solicitação destinada ao servidor. Dependendo das formas de entrada utilizadas, a solicitação pode conter um relato textual, um arquivo de áudio, uma imagem ou uma combinação desses conteúdos.

Os dados são organizados por meio da interface `BodyParser`, adequada ao envio conjunto de campos textuais e arquivos. O texto é adicionado somente quando estiver preenchido, enquanto o áudio e a imagem são anexados diretamente como objetos Blob e File, respectivamente.

A comunicação entre a aplicação cliente e o #emph[backend] é realizada por meio da Fetch #abbrev("API"), utilizando uma requisição HTTP do tipo POST. O objeto que representa a ocorrência é convertido para JSON com o método `JSON.stringify()`. Nesse caso, o cabeçalho Content-Type deve ser definido como `application/json`, informando ao servidor o formato do corpo da requisição.

Antes do envio, a aplicação verifica se pelo menos uma forma de entrada foi fornecida. Caso não exista texto, áudio ou imagem, a solicitação é interrompida e uma mensagem é apresentada ao usuário. Uma variável de controle também impede que uma nova requisição seja iniciada enquanto a anterior ainda estiver em processamento.

#codigo(
  lang: "javascript",
  caption: [Envio da ocorrência ao servidor],
  filename: "submit.js",
  read("assets/codigos/submit.js"),
)

Após o envio da solicitação pela aplicação cliente, o #emph[backend] recebe o corpo da requisição em formato JSON. O middleware `bodyParser`.json() é responsável por interpretar esse conteúdo e disponibilizá-lo no objeto req.body. O limite de tamanho aceito pelo middleware foi ampliado devido à presença dos arquivos de áudio e imagem codificados em Base64, representação que aumenta o volume de dados transmitidos.

Depois da interpretação do corpo da requisição, o endpoint extrai de req.body os dados enviados pela aplicação cliente. Esses dados incluem o relato textual, o áudio, a imagem, as coordenadas geográficas e o horário da ocorrência.

=== Tela de Espera

Após o envio da solicitação, a aplicação redireciona o usuário para uma tela intermediária, ilustrada em @fig:tela_espera. Essa tela tem como objetivo fornecer um retorno visual imediato de que a requisição foi recebida e está sendo processada pelo servidor, evitando que o usuário interprete a ausência de resposta como uma falha na aplicação.

A interface apresenta uma animação de carregamento acompanhada de uma mensagem informando que a ocorrência está sendo analisada. Durante esse período, novas interações relacionadas à solicitação são bloqueadas, impedindo o envio duplicado da mesma ocorrência e garantindo que apenas uma requisição permaneça em processamento.

A tela permanece visível até que o servidor retorne uma resposta contendo a recomendação do serviço de emergência ou informe a ocorrência de algum erro durante o processamento da solicitação.

#figura(
  image("assets/imagens/tela-espera.png", width: 70%),
  caption: [Tela de espera],
) <fig:tela_espera>

=== Tela de Resposta

Após o processamento da solicitação, a aplicação apresenta ao usuário a tela de resposta, ilustrada na @fig:diagrama_desenvolvimento_frontend_resultado. Essa interface foi projetada para que destaque as informações mais relevantes da recomendação gerada, permitindo que o usuário identifique rapidamente qual serviço de emergência deve ser acionado.

A tela exibe o nome do serviço recomendado, seu respectivo número telefônico e um resumo da ocorrência interpretada pelo sistema, oferecendo ao usuário uma justificativa simplificada da decisão tomada. Além disso, é apresentado um aviso informando que a recomendação foi produzida por um modelo de inteligência artificial e deve ser utilizada como um recurso de apoio, não substituindo a avaliação do próprio usuário diante da situação de emergência.

#figura(
  image("assets/imagens/tela-resultado.png", width: 70%),
  caption: [Tela de resposta com recomendação],
) <fig:diagrama_desenvolvimento_frontend_resultado>

==== Recebimento da Resposta

O recebimento da resposta ocorre após a conclusão da requisição HTTP iniciada durante o envio da solicitação. Quando o servidor conclui o processamento, a aplicação interpreta o corpo da resposta por meio do método response.json(), que converte o conteúdo JSON recebido em um objeto JavaScript.

Uma resposta válida deve conter os campos `service_name`, `phone_number` e `emergency_context`, correspondentes, respectivamente, ao serviço de emergência recomendado, ao número de telefone e ao resumo da ocorrência identificado pelo modelo. Antes de apresentar o resultado, a aplicação verifica a existência e o tipo desses campos.

Caso a resposta seja válida, os elementos da interface são atualizados dinamicamente e a aplicação realiza a transição da tela de espera para a tela de resposta. Se o servidor retornar um erro ou se o conteúdo recebido não apresentar a estrutura esperada, a aplicação exibe uma mensagem informando que não foi possível concluir a análise e retorna o usuário à tela inicial.

#codigo(
  lang: "javascript",
  caption: [Tratamento da resposta do servidor],
  filename: "handle.js",
  read("assets/codigos/handle.js"),
)

==== Redirecionamento para Ligação

Após a apresentação da recomendação, o usuário pode iniciar o contato com o serviço de emergência por meio do botão “Ligar Agora”. A funcionalidade utiliza o esquema de URI tel:, reconhecido pelos navegadores e pelos dispositivos móveis.

Ao acionar o botão, a aplicação abre o discador do dispositivo com o número recomendado previamente preenchido. A ligação não é realizada automaticamente, pois ainda depende da confirmação do usuário no aplicativo de chamadas.

O endereço do botão é definido somente após o recebimento e a validação da resposta do servidor. Antes de construir a URI, caracteres que não representam dígitos são removidos do número recebido. 

#codigo(
  lang: "javascript",
  caption: [Redirecionamento para ligação],
  filename: "call.js",
  read("assets/codigos/call.js"),
)

Essa abordagem elimina a necessidade de memorizar ou digitar manualmente o número recomendado, reduzindo o tempo necessário para acessar o serviço e a possibilidade de erros de discagem. Após o encerramento da ligação, o usuário pode retornar à aplicação e iniciar uma nova solicitação, caso seja necessário. 

== Implementação do Servidor

O servidor foi estruturado de forma modular, separando a inicialização da aplicação, o gerenciamento das requisições HTTP, o processamento das ocorrências, a comunicação com serviços externos e as funções auxiliares. Essa organização permite que cada parte do sistema seja modificada de maneira relativamente independente, reduzindo a concentração da lógica em um único arquivo e facilitando a identificação das responsabilidades de cada componente.

A inicialização do sistema ocorre no arquivo principal da aplicação, responsável por carregar o módulo HTTP e iniciar o servidor na porta 27020. O serviço é configurado para aceitar conexões em todas as interfaces de rede disponíveis, por meio do endereço 0.0.0.0, possibilitando o acesso ao #emph[backend] a partir de outros dispositivos conectados à rede ou de uma infraestrutura remota.

A camada de comunicação HTTP foi implementada com o framework Express. Nela são configurados os middlewares responsáveis pela interpretação dos corpos das requisições nos formatos JSON e URL encoded. Também foi habilitado o Cross-Origin Resource Sharing (CORS), permitindo que aplicações executadas em origens distintas realizem requisições ao servidor. Essa configuração é necessária porque a aplicação cliente e o #emph[backend] podem ser executados em dispositivos ou endereços diferentes.

#codigo(
  lang: "javascript",
  caption: [Inicialização do servidor],
  filename: "main.js",
  read("assets/codigos/main.js"),
)

#codigo(
  lang: "javascript",
  caption: [Inicialização do servidor],
  filename: "main.js",
  read("assets/codigos/express.js"),
)

Os endpoints da aplicação são carregados automaticamente a partir do diretório destinado às rotas do servidor. Durante a inicialização, o sistema percorre os arquivos JavaScript presentes nesse diretório, importa seus respectivos módulos e registra uma rota HTTP do tipo POST com o mesmo nome de cada arquivo. Dessa forma, o arquivo help.js é disponibilizado como o endpoint /help, responsável pelo recebimento e pelo processamento das solicitações de emergência.

Antes de encaminhar a requisição ao endpoint correspondente, a camada Express 
registra o endereço de origem da conexão, verifica a existência do corpo da requisição e define o tipo de conteúdo da resposta como JSON com codificação UTF-8. Após essas verificações, o controle é transferido ao módulo responsável pela rota solicitada.

#codigo(
  lang: "javascript",
  caption: [Handler de Endpoints],
  filename: "main.js",
  read("assets/codigos/handleendpoint.js"),
)

O endpoint /help concentra a coordenação do fluxo de atendimento. Esse módulo recebe os dados enviados pelo cliente, valida a presença das coordenadas geográficas, obtém a localização aproximada da ocorrência, organiza as informações em uma estrutura de contexto, constrói os prompts e solicita o processamento ao modelo de linguagem. Ao final, o resultado estruturado é devolvido à aplicação cliente por meio da resposta HTTP.

A comunicação com o serviço de geocodificação foi isolada em um módulo responsável pelas requisições de rede. Esse componente realiza a consulta à #abbrev("API") Google Reverse Geocoding, utilizada para converter as coordenadas geográficas da ocorrência em informações textuais de localização. Esse processo permite complementar os dados de latitude e longitude com elementos de endereço mais compreensíveis e relevantes para a análise da ocorrência.

Para realizar a consulta, o servidor insere as coordenadas recebidas no endereço da #abbrev("API") e envia uma requisição HTTP. Após o recebimento da resposta em formato JSON, os dados são encaminhados à função extractLocation(), responsável por percorrer os componentes do endereço e identificar os campos utilizados pelo sistema, como rua, bairro, cidade, estado, país e código postal. Ao final do processamento, essas informações são organizadas em um objeto e posteriormente incorporadas ao contexto da ocorrência.

#codigo(
  lang: "javascript",
  caption: [Geocodificação reversa],
  filename: "geocode.js",
  read("assets/codigos/geocode.js"),
)

Na comunicação com a plataforma de distribuição de modelos, o servidor organiza a requisição de acordo com o formato de mensagens utilizado pela #abbrev("API"). São incluídas uma mensagem de sistema, uma mensagem de contextualização e uma mensagem contendo os dados fornecidos pelo usuário. Quando arquivos de imagem ou áudio estão presentes, eles são lidos do diretório de recursos, convertidos para Base64 e incorporados ao conteúdo multimodal da requisição.

A resposta retornada pelo modelo também é tratada nessa camada. Além do conteúdo gerado, o módulo registra informações relacionadas à execução, como tempo de resposta, quantidade de tokens de entrada e saída e custo informado pela #abbrev("API"). O conteúdo produzido pelo modelo é encaminhado à função extraction(), responsável por remover eventuais marcações de bloco de código e convertê-lo em um objeto JSON válido.

As funções utilitárias também foram reunidas em um módulo próprio. Entre elas estão a criação e localização de arquivos, o registro persistente de logs, a formatação das mensagens exibidas no terminal, a conversão de arquivos para Base64, a extração de objetos JSON e a interpretação dos dados retornados pelo serviço de geocodificação.

A função fileToBase64() realiza a leitura síncrona do arquivo e converte seu conteúdo para uma sequência Base64. A função extractJson(), por sua vez, tenta interpretar diretamente a resposta como JSON. Caso existam textos ou marcações adicionais, a função localiza o primeiro objeto delimitado por chaves e realiza uma nova tentativa de conversão.

#codigo(
  lang: "javascript",
  caption: [Para Base64],
  filename: "tobase64.js",
  read("assets/codigos/tobase64.js"),
)

A @fig:arquitetura-geral apresenta a relação entre os principais componentes da arquitetura. A aplicação cliente envia a solicitação ao endpoint /help, que coordena o processamento e utiliza os módulos de prompt, geocodificação e comunicação com o modelo. Após a interpretação e validação da resposta, o resultado estruturado é devolvido ao cliente

#figura(image("assets/imagens/arquitetura-geral.png", width: 90%), caption: [Arquitetura geral do sistema]) <fig:arquitetura-geral>

A separação adotada também evita que as credenciais de acesso sejam expostas na aplicação cliente, uma vez que as chaves utilizadas pelo Google Maps e pelo modelo IA permanecem armazenadas nas variáveis de ambiente do servidor. Além disso, a centralização das integrações no #emph[backend] permite alterar o modelo de linguagem, os prompts ou os serviços externos sem exigir modificações diretas na interface da aplicação.

== Construção do Prompt

Antes de realizar a comunicação com o modelo de linguagem, o servidor constrói o conjunto de mensagens que será encaminhado à #abbrev("API") do Open Router. Esse conjunto, denominado prompt, define tanto o comportamento esperado do modelo quanto às informações específicas da ocorrência que deverão ser consideradas durante a classificação.

Em vez de encaminhar apenas o relato fornecido pelo usuário, o sistema complementa a solicitação com informações contextuais obtidas automaticamente durante o processamento, como localização geográfica e horário da ocorrência. Essa estratégia reduz ambiguidades e fornece ao modelo mais elementos para identificar o serviço de emergência adequado.

Na implementação desenvolvida, o prompt é organizado em três componentes: System Prompt, Assistant Prompt e mensagem do usuário. Cada componente é enviado com um papel diferente na estrutura de mensagens utilizada pela #abbrev("API").

O System Prompt estabelece a função do modelo, o processo de análise, as restrições da classificação e o formato obrigatório da resposta. Entre as regras definidas estão a consideração conjunta das modalidades de entrada, a escolha de apenas um serviço, a priorização de órgãos oficiais, a proibição de inventar informações e a exigência de uma resposta em JSON.

#codigo(lang: "javascript", caption: [System Prompt], filename: "systemprompt.js", read("assets/codigos/systemprompt.js"))

O segundo componente corresponde ao Assistant Prompt, gerado dinamicamente para cada requisição. Diferentemente do System Prompt, esse componente apresenta informações específicas da ocorrência, como horário, rua, bairro, cidade, estado, país e código postal.

Essas informações são obtidas a partir do objeto de contexto construído pelo endpoint /help. Dessa forma, cada solicitação recebe sua própria contextualização antes de ser encaminhada ao modelo.

#codigo(lang: "javascript", caption: [Assistant Prompt contextual], filename: "assistantprompt.js", read("assets/codigos/assistantprompt.js"))

O terceiro componente corresponde à mensagem do usuário. Ela reúne o conteúdo efetivamente fornecido pela aplicação cliente e pode conter texto, imagem, áudio ou uma combinação dessas modalidades.

O relato textual é inserido como conteúdo do tipo text. As imagens são convertidas para Base64 e incorporadas como `Data URI` no campo image_url. Os arquivos de áudio também são convertidos para Base64 e adicionados como conteúdo do tipo input_audio, acompanhado da identificação de seu formato.

#codigo(lang: "javascript", caption: [Criação do content], filename: "buildcontent.js", read("assets/codigos/buildcontent.js"))

Após a preparação dos três componentes, as mensagens são organizadas conforme os papéis esperados pela #abbrev("API"). As regras de classificação são enviadas com o papel system, a contextualização da ocorrência com o papel assistant e os dados fornecidos pelo usuário com o papel user.

=== Contextualização da Ocorrência

Uma característica importante da implementação é que o modelo de linguagem não recebe apenas o relato informado pelo usuário. Antes da comunicação com a #abbrev("API"), o servidor realiza uma etapa de enriquecimento da solicitação, incorporando informações adicionais obtidas durante o processamento da requisição.

Entre esses dados encontram-se a latitude e longitude fornecidas pelo dispositivo móvel, o endereço aproximado obtido por meio do Google Reverse Geocoding e o horário em que a solicitação foi realizada. Essas informações são reunidas no objeto de contexto da aplicação e utilizadas para compor o Assistant Prompt.

A inclusão desse contexto permite reduzir ambiguidades presentes em descrições curtas ou incompletas. Por exemplo, um usuário pode informar apenas "há um incêndio próximo de casa". Embora essa descrição indique a natureza da ocorrência, ela não fornece qualquer informação sobre sua localização. Ao incorporar automaticamente o endereço aproximado da ocorrência, o servidor fornece ao modelo elementos adicionais para interpretar a situação de maneira mais consistente e selecionar o serviço de emergência adequado.

Além das informações geográficas, o sistema também encaminha os conteúdos multimodais presentes na solicitação. Quando imagens ou gravações de áudio são fornecidas, esses arquivos são preparados pelo servidor e enviados juntamente com as mensagens textuais, permitindo que modelos compatíveis realizem uma análise conjunta das diferentes modalidades de entrada.

=== Formato de Saída (JSON)

Após concluir a análise da ocorrência, o modelo deve produzir uma resposta estruturada em formato JSON. A utilização de um formato padronizado elimina a necessidade de interpretar respostas em linguagem natural e reduz a possibilidade de ambiguidades durante a comunicação entre o servidor e a aplicação cliente.

O System Prompt instrui explicitamente o modelo a responder exclusivamente com um objeto JSON válido, sem comentários, blocos de código ou qualquer texto adicional. Essa restrição simplifica o processamento realizado pelo servidor, que pode converter diretamente a resposta recebida em um objeto da aplicação.

Na implementação atual, o JSON contém três campos obrigatórios: `service_name`, responsável por identificar o órgão de atendimento recomendado; `phone_number`, contendo o número telefônico correspondente; e `emergency_context`, que apresenta um resumo objetivo da interpretação realizada pelo modelo.

Após o recebimento da resposta, o servidor verifica se esses campos estão presentes antes de encaminhar o resultado à aplicação cliente. Caso a estrutura não esteja de acordo com o formato esperado, a resposta é considerada inválida e uma mensagem de erro é retornada ao cliente. Essa validação reduz falhas de integração e garante que apenas respostas compatíveis com a arquitetura da aplicação sejam utilizadas durante o atendimento das ocorrências.

== Integração com Modelos de Linguagem

Para realizar a integração com Modelos de Linguagem, foi utilizado o OpenRouter, uma plataforma que centraliza o acesso a modelos de inteligência artificial desenvolvidos e disponibilizados por diferentes provedores. Por meio de uma interface de programação unificada, a plataforma atua como intermediária entre a aplicação e os modelos selecionados, padronizando o formato das requisições e respostas.

Essa abordagem simplifica a implementação do servidor, uma vez que as requisições seguem uma estrutura comum independentemente do modelo selecionado. Além disso, a interface unificada facilita a substituição ou inclusão de novos modelos durante o desenvolvimento e a realização dos experimentos.

A comunicação com os modelos é inteiramente realizada no servidor. Dessa forma, as credenciais de acesso à #abbrev("API") permanecem protegidas e não são expostas na aplicação cliente, reduzindo os riscos de utilização indevida e permitindo maior controle sobre os modelos empregados pelo sistema.

=== Comunicação com o OpenRouter
A comunicação com o OpenRouter é realizada por meio de uma requisição HTTP do tipo POST para o endpoint de modelos conversacionais disponibilizado pela plataforma. O corpo da requisição é transmitido em formato JSON e segue a estrutura de mensagens definida pela #abbrev("API").

Após a construção dos prompts e a preparação dos conteúdos multimodais, o servidor organiza a requisição com o identificador do modelo selecionado, as mensagens correspondentes aos papéis system, assistant e user e a indicação de que a resposta não deve ser transmitida de forma fragmentada. A autenticação é realizada por meio de uma chave de acesso armazenada nas variáveis de ambiente do servidor.

#codigo(lang: "javascript", caption: [Criação do content], filename: "requestopenrouter.js", read("assets/codigos/requestopenrouter.js"))

A chave utilizada na autenticação não é incorporada diretamente ao código-fonte. Ela é obtida por meio do pacote dotenv, que carrega as variáveis definidas no ambiente de execução do servidor. Essa abordagem evita que a credencial seja exposta na aplicação cliente ou registrada diretamente nos arquivos da aplicação. 

Após o processamento realizado pelo modelo, o OpenRouter retorna um objeto JSON contendo o conteúdo gerado e informações relacionadas à execução da requisição. O servidor registra o tempo decorrido entre o envio e o recebimento da resposta, além da quantidade de tokens de entrada, saída e total, e do custo informado pela #abbrev("API").

Essas informações são armazenadas juntamente com o resultado e utilizadas durante o #emph[benchmark] para comparar o comportamento dos modelos avaliados. O tempo registrado representa a duração total observada pelo servidor durante a comunicação, incluindo o processamento remoto e a transmissão da resposta.

#codigo(lang: "javascript", caption: [Criação do content], filename: "openrouteres.js", read("assets/codigos/openrouteres.js"))

Antes de encaminhar a recomendação à aplicação cliente, o servidor verifica se o conteúdo retornado foi convertido em um objeto JSON e se apresenta os três campos obrigatórios: `service_name`, `phone_number` e `emergency_context`.

Caso a resposta não possua a estrutura esperada, o resultado é considerado inválido e o servidor retorna uma mensagem de erro. Quando a validação é concluída com sucesso, somente os campos necessários à tela de resposta são encaminhados ao cliente.

#codigo(lang: "javascript", caption: [Criação do content], filename: "validateopenrouter.js", read("assets/codigos/validateopenrouter.js"))

= Análise dos Resultados

Com o desenvolvimento da prova de conceito, tornou-se necessário avaliar como diferentes modelos de linguagem se comportam quando integrados à arquitetura proposta. Essa etapa teve como finalidade verificar não apenas a capacidade dos modelos de produzir respostas, mas também sua adequação às necessidades do Centro de Ajuda, especialmente diante das diferentes formas de entrada previstas pelo sistema.

A avaliação considera aspectos relacionados à interpretação de texto, áudio e imagem, ao cumprimento do formato de resposta estabelecido, à adequação do serviço recomendado e ao comportamento apresentado durante a comunicação com a #abbrev("API"). Também foram observados indicadores como tempo de resposta, custo e quantidade de #emph[tokens] processados, permitindo analisar tanto os resultados produzidos quanto às condições técnicas de utilização de cada modelo.

Para possibilitar essa comparação, foi elaborado um #emph[benchmark] composto por cenários padronizados, representativos das modalidades de entrada suportadas pela aplicação. Os mesmos casos foram submetidos aos modelos selecionados por meio da infraestrutura implementada no servidor, proporcionando condições semelhantes de execução e permitindo identificar diferenças de compatibilidade, funcionamento e desempenho entre eles.

== Modelos Testados

Os modelos utilizados no #emph[benchmark] correspondem aos mesmos modelos previamente selecionados durante a etapa metodológica deste trabalho. A escolha considerou critérios relacionados à disponibilidade comercial, integração por #abbrev("API"), suporte ao processamento multimodal e possibilidade de utilização em infraestrutura em nuvem. O #emph[benchmark] tem como objetivo verificar, na prática, como esses modelos se comportam quando submetidos ao fluxo completo implementado na prova de conceito, complementando a análise teórica apresentada anteriormente. 

Foram avaliados os modelos: OpenAI GPT-5.5; Anthropic Claude Opus 4.8; Meta Llama 4 Maverick; Alibaba Qwen 3.6 Plus; Google Gemini 3.5 Flash; NVIDIA Nemotron 3 Nano Omni 30B A3B Reasoning; Cohere North Mini Code.

Todos os modelos foram acessados por meio da plataforma OpenRouter, permitindo que as solicitações utilizassem uma interface padronizada independentemente do provedor responsável pelo modelo.

== Cenários Testados

A avaliação utilizou quatro cenários de emergência elaborados para representar diferentes combinações de modalidades de entrada suportadas pela aplicação. A tabela abaixo apresenta uma síntese desses cenários, indicando a situação representada e as modalidades fornecidas em cada teste. Em seguida, cada cenário é descrito individualmente. 

#tabela(
  caption: [Cenários testados], 
  columns: (1fr,1fr), 
  width: 50%,
  header: ([Cenário],[Entrada]), 
  [Primeiro],[Texto],
  [Segundo],[Texto e Imagem],
  [Terceiro],[Áudio],
  [Quarto],[Áudio e Imagem]) <tab:cenarios_testados>

O primeiro cenário utiliza apenas descrição textual, simulando uma situação na qual um veículo apresenta defeito no acostamento de uma rodovia durante o período noturno. 

O segundo cenário combina texto e imagem, representando uma árvore caída sobre fios elétricos após uma tempestade, permitindo avaliar a utilização conjunta de informações textuais e visuais. 

O terceiro cenário utiliza apenas áudio, simulando o relato de um atropelamento de animal, permitindo verificar tanto a compatibilidade dos modelos com processamento sonoro quanto sua capacidade de interpretar o conteúdo da gravação. 

O quarto cenário combina áudio e imagem, representando uma residência sendo invadida pela água durante fortes chuvas. Esse cenário foi desenvolvido para avaliar a capacidade dos modelos de integrar simultaneamente informações provenientes de diferentes modalidades durante a classificação da ocorrência. Todos os cenários também incluem coordenadas geográficas e horário da ocorrência, permitindo que o servidor complemente automaticamente o contexto antes da comunicação com o modelo de linguagem.

== Coleta de Resultados

Ao término de cada execução, o #emph[benchmark] registra integralmente os dados utilizados durante a solicitação e a resposta produzida pelo modelo. Inicialmente essas informações são armazenadas no arquivo `benchmark.txt`, preservando tanto os dados de entrada quanto o objeto retornado pela integração com o OpenRouter.

Além da resposta produzida pelo modelo, também são registrados indicadores técnicos fornecidos pela #abbrev("API"), incluindo o tempo de resposta, o custo estimado da requisição e as quantidades de #emph[tokens] de entrada, de saída e total. Quando a execução não é concluída com sucesso, o código e a mensagem de erro retornados pelo provedor também são armazenados. A tabela abaixo reúne exemplos de métricas registradas para os sete modelos. Como ela não identifica o cenário correspondente a cada coluna nem apresenta repetições, seus valores são descritivos e não fundamentam um ranking de custo ou desempenho. 

#tabela(caption: [Exemplo de métricas por modelo], 
  columns: (7fr, 2fr, 2fr, 2fr, 2fr, 3fr, 4fr, 1fr), 
  align: (left, center),
  font-size: 10pt, 
  header: ([Parâmetro],[GPT-5.5],[Claude],[Llama],[Qwen],[Gemini],[Nemotron],[North]), 
  [cost (dólares)],[0.107],[0.114],[0.006],[0.011],[0.012],[0.005],[0.005],
  [response_time_ms (ms)],[44059],[11028],[2634],[47734],[10398],[3910],[6445],
  [prompt_tokens (tokens)],[15370],[19821],[3658],[3837],[524],[3982],[3655],
  [completion_tokens (tokens)],[972],[227],[48],[2496],[1336],[351],[497]) <tab:exemplo_retorno_nemotron>

== Comparação por Critérios

Nesta primeira análise, os modelos foram avaliados isoladamente, sem transcrição ou interpretação prévia por modelos auxiliares. Os resultados se referem às rotas e às requisições utilizadas no OpenRouter, e não a todas as funcionalidades disponíveis nas plataformas dos fabricantes.

As classificações da @tab:comparacao_modelos foram atribuídas a partir das respostas, mensagens de erro e ausências de resultado descritas na análise individual, conforme as definições de @sec:metodos-avaliacao. “Sucesso” exige uma resposta que reconheça a ocorrência; “Falha” abrange erro de execução ou incompreensão do conteúdo; “Sem resultado” preserva a incerteza de um registro vazio. No critério JSON, a presença dos três campos obrigatórios é avaliada separadamente da correção de seus valores.

#tabela(
  caption: [Resultados por critério e cobertura das respostas — modelo isolado],
  columns: (2fr,1fr,1fr,1fr,1fr,1fr,1fr,1fr),
  align: (left, center),
  font-size: 10pt,
  header: ([Critério],[GPT],[Claude],[Llama],[Qwen],[Gemini],[Nemotron],[North]),
  [Texto],[Sucesso],[Sucesso],[Sucesso],[Sucesso],[Sucesso],[Sucesso],[Sucesso],
  [Texto + imagem],[Sucesso],[Falha],[Sucesso],[Sucesso],[Sucesso],[Sucesso],[Falha],
  [Áudio],[Falha],[Falha],[Falha],[Falha],[Sucesso],[Falha],[Falha],
  [Áudio + imagem],[Falha],[Falha],[Falha],[Falha],[Sucesso],[Sem resultado],[Falha],
  [JSON],[Parcial],[Parcial],[Parcial],[Parcial],[Completo],[Parcial],[Parcial],
  [Cenários com interpretação compatível],[2/4],[1/4],[2/4],[2/4],[4/4],[2/4],[1/4],
) <tab:comparacao_modelos>

Fonte: elaboração própria a partir das execuções descritas neste trabalho. A cobertura expressa o número de cenários com reconhecimento do conteúdo central da ocorrência; não representa uma taxa de acerto validada dos serviços ou dos telefones recomendados.

=== Origem e Motivos das Falhas

No *GPT-5.5*, os cenários com áudio retornaram o código 404 e a mensagem `No endpoints found that support input audio`. A falha ocorreu na seleção de uma rota compatível, antes da interpretação. Texto e texto com imagem produziram respostas, mas o JSON foi classificado como parcial porque não houve a estrutura esperada nos dois casos com áudio.

No *Claude Opus 4.8*, texto com imagem retornou o código 400 e a mensagem `Provider returned error`. Esse registro identifica uma falha de execução, mas não esclarece sua causa. Os dois cenários com áudio retornaram o erro 404 de incompatibilidade com essa modalidade. Como apenas o cenário textual produziu a resposta esperada, a cobertura foi de um cenário e o JSON foi parcial.

No *Llama 4 Maverick* e no *Qwen 3.6 Plus*, os dois cenários sem áudio produziram respostas compatíveis com o conteúdo central das entradas. Os cenários com áudio retornaram o código 404 por ausência de endpoint compatível. Por isso, ambos tiveram cobertura de dois cenários e JSON parcial; não houve evidência de avaliação semântica do áudio nessas execuções.

No *Gemini 3.5 Flash*, os quatro cenários produziram os campos exigidos e resumos compatíveis com as ocorrências. Não foi registrada falha de processamento nessas combinações, justificando a cobertura de quatro cenários e o JSON completo. Esse resultado não elimina a necessidade de verificar os contatos locais apresentados pelo modelo.

No *Nemotron 3 Nano Omni*, o áudio foi aceito, mas a resposta afirmou que a ocorrência não havia sido especificada, embora a gravação descrevesse um animal atropelado. Trata-se de falha de compreensão, e não de incompatibilidade técnica demonstrada. No cenário com áudio e imagem, o registro vazio não permite identificar se a interrupção ocorreu na chamada, no retorno ou na gravação do resultado. O JSON foi parcial e apenas os dois cenários sem áudio apresentaram interpretação compatível.

No *North Mini Code*, texto com imagem retornou o código 404 com a mensagem `No endpoints found that support image input`; o cenário de áudio apresentou incompatibilidade com entrada sonora; e áudio com imagem voltou a apresentar incompatibilidade com imagem. Como apenas texto produziu resposta, o JSON foi parcial e a cobertura ficou restrita a um cenário.

=== Adequação das Recomendações

A adequação foi examinada separadamente da cobertura, pois reconhecer uma ocorrência não garante a escolha correta do órgão ou do telefone. No cenário textual, GPT e Llama indicaram, respectivamente, atendimento rodoviário estadual e federal, embora a jurisdição da via não estivesse estabelecida. Claude e Qwen reuniram órgãos distintos no nome do serviço, mas apresentaram apenas um telefone. Essas respostas reconheceram o relato, porém apresentaram ressalvas quanto à precisão institucional.

No cenário da árvore sobre a fiação, as respostas de GPT, Llama e Qwen foram relacionadas ao risco descrito, mas o contato local informado pelo Llama não foi validado externamente nesta avaliação. O Gemini reconheceu os quatro cenários, incluindo o relato sonoro, mas o estabelecimento veterinário e seu telefone também permaneceram sujeitos a confirmação. No Nemotron, somaram-se a suposição de jurisdição rodoviária, a baixa confiabilidade do telefone apresentado para a concessionária e a incompreensão do áudio. O North apresentou uma resposta textual compatível, sem cobertura das demais entradas.

Por essas razões, a comparação utiliza descrições das evidências e das ressalvas, em lugar de notas globais como “Boa”, “Excelente” ou “Regular”. Sem uma escala validada e respostas de referência, esses adjetivos poderiam sugerir uma precisão que o experimento não oferece.


=== Segunda Análise: Viabilidade de Composição

A avaliação isolada verifica se uma única rota atende às entradas previstas pela aplicação. Para examinar alternativas às limitações observadas, foi realizado um levantamento complementar de possíveis composições entre modelos disponíveis no OpenRouter. Nesse fluxo, um modelo auxiliar interpreta áudio ou imagem e encaminha uma representação textual ao modelo responsável pela classificação.

A @tab:comparacao_ecossistemas sintetiza as possibilidades descritas no levantamento. “Viável” indica a identificação de componentes para formar o fluxo; “Não identificada” indica que não foi encontrada uma composição correspondente no recorte consultado; e “Condicional” destaca uma possibilidade cuja etapa de percepção apresentou problemas nos testes. Essas classificações não são resultados de execuções completas das composições.

#tabela(
  caption: [Viabilidade de composição por ecossistema],
  columns: (2fr,1fr,1fr,1fr,1fr,1fr,1fr,1fr),
  font-size: 9pt,
  header: ([Entrada],[GPT],[Claude],[Llama],[Qwen],[Gemini],[Nemotron],[North]),
  [Texto],[Viável],[Viável],[Viável],[Viável],[Viável],[Viável],[Viável],
  [Texto + imagem],[Viável],[Viável],[Viável],[Viável],[Viável],[Viável],[Não identificada],
  [Áudio],[Viável],[Não identificada],[Viável],[Não identificada],[Viável],[Condicional],[Não identificada],
  [Áudio + imagem],[Viável],[Não identificada],[Viável],[Não identificada],[Viável],[Condicional],[Não identificada],
) <tab:comparacao_ecossistemas>

Fonte: elaboração própria a partir do levantamento de composições descrito neste trabalho. A indicação de viabilidade não altera a cobertura medida na avaliação dos modelos isolados.

Os fluxos considerados para GPT e Llama acrescentam uma etapa de interpretação sonora antes da classificação. Para Claude, foi considerada a descrição da imagem por um componente auxiliar, sem alternativa sonora identificada. Qwen permaneceu sem uma composição sonora identificada, e North sem alternativas multimodais no recorte consultado. No caso do Nemotron, a separação entre percepção e classificação não resolve automaticamente o erro de compreensão observado no áudio.

O levantamento não fornece métricas comparáveis de custo, latência ou qualidade final das composições. Esses aspectos precisam ser medidos em novas execuções, com registro das saídas intermediárias, pois erros de transcrição ou descrição podem ser propagados ao classificador.


== Análise Individual dos Modelos

Para aprofundar as duas comparações anteriores, cada modelo foi analisado individualmente tanto em relação aos resultados obtidos no #emph[benchmark] quanto às possibilidades oferecidas por seu ecossistema no OpenRouter. Dessa forma, a análise considera primeiro o comportamento do modelo utilizado isoladamente e, em seguida, verifica se suas limitações podem ser contornadas com o uso de modelos auxiliares.

Foram considerados seis critérios: processamento textual, processamento de imagem, processamento de áudio, processamento conjunto de áudio e imagem, geração do JSON esperado e adequação da recomendação produzida. Na análise dos ecossistemas, também foram observadas a disponibilidade de modelos especializados e a possibilidade de executar múltiplos modelos em sequência.

O processamento de uma modalidade foi considerado bem-sucedido quando a requisição foi aceita pelo provedor e produziu uma resposta associada ao conteúdo enviado. Portanto, o simples fato de a #abbrev("API") aceitar um arquivo não significa que seu conteúdo tenha sido corretamente compreendido. Essa diferença é especialmente importante na análise do Nemotron, que aceitou uma das solicitações contendo áudio, mas não identificou adequadamente a ocorrência relatada.

A adequação da resposta foi examinada considerando a correspondência entre a ocorrência, o serviço recomendado, o número informado e o resumo produzido. Esse critério possui natureza qualitativa. A avaliação foi realizada com base nos dados disponíveis no #emph[benchmark] e não representa uma validação oficial de todos os telefones locais apresentados pelos modelos.

=== GPT-5.5

O GPT-5.5 concluiu os dois cenários que não continham áudio. No cenário textual, referente ao veículo parado no acostamento, recomendou a Polícia Rodoviária Estadual da Bahia e informou o número 198. A resposta considerou corretamente a presença de uma passageira idosa, o anoitecer e a sensação de insegurança. O contexto produzido foi coerente com a entrada e apresentou todos os campos exigidos. Entretanto, a jurisdição estadual da rodovia não estava estabelecida no cenário, de modo que essa especificidade da recomendação não foi confirmada pelos dados fornecidos.

No cenário composto por texto e imagem, o modelo recomendou o Corpo de Bombeiros, por meio do número 193, para a árvore caída sobre fios elétricos. A recomendação foi considerada satisfatória, pois a ocorrência envolvia risco de choque, faíscas e bloqueio da via.

Entretanto, os dois cenários que continham áudio falharam antes da inferência. Em ambos os casos, o OpenRouter retornou o código 404 e a mensagem `No endpoints found that support input audio`. Portanto, a falha não ocorreu na interpretação semântica do áudio, mas na indisponibilidade de um endpoint compatível com essa modalidade para o modelo e a rota utilizados.

Na análise complementar, foi considerado um fluxo em que o GPT Audio interpreta o arquivo sonoro e produz uma representação textual para o GPT-5.5. No cenário com áudio e imagem, essa representação poderia ser enviada juntamente com a imagem ao classificador. Trata-se de uma possibilidade de composição; os registros apresentados não demonstram o desempenho completo desse fluxo nem ampliam a cobertura medida para o GPT-5.5 isolado.

=== Claude Opus 4.8

O Claude Opus 4.8 concluiu somente o cenário textual. A resposta recomendou “Polícia Rodoviária / Polícia Militar” e apresentou o número 190. O resumo interpretou adequadamente o veículo parado, a presença da idosa e a insegurança no acostamento. Apesar disso, o nome do serviço ficou ambíguo, pois reuniu dois órgãos diferentes enquanto apresentava apenas o telefone da Polícia Militar.

No cenário de texto e imagem, o provedor retornou o código 400 e a mensagem Provider returned error. O resultado não permite afirmar que o Claude seja incapaz de processar imagens de forma geral, mas demonstra que a solicitação visual não foi processada com sucesso na configuração usada no #emph[benchmark]. Diferentemente de uma mensagem explícita de incompatibilidade, esse erro é genérico e pode estar relacionado ao provedor selecionado pelo OpenRouter, ao formato da requisição ou à disponibilidade momentânea da rota.

Nos dois testes contendo áudio, o resultado foi o código 404 com a mensagem `No endpoints found that support input audio`. Dessa forma, não houve processamento do áudio nem da combinação entre áudio e imagem.

Na análise complementar, foi considerada a possibilidade de um modelo Claude com suporte visual descrever a imagem antes de encaminhar o texto ao Claude Opus 4.8. O levantamento não identificou uma alternativa sonora no mesmo ecossistema e recorte do OpenRouter. A composição visual exige teste próprio e não esclarece, por si só, a causa do erro 400 observado na execução original. 

=== Llama 4 Maverick

O Llama 4 Maverick concluiu os cenários textual e visual. No primeiro, recomendou a Polícia Rodoviária Federal e informou o número 191. A resposta identificou corretamente o risco de permanecer no acostamento com uma pessoa idosa durante o anoitecer. Entretanto, a entrada não indicava que o veículo estava em uma rodovia federal. Dessa forma, a escolha da #abbrev("PRF", long: "Polícia Rodoviária Federal") foi considerada parcialmente adequada, pois introduziu uma especificidade que não estava confirmada pelo contexto.

No cenário da árvore sobre a fiação, o modelo recomendou a Coelba e apresentou o número 0800 071 0909. A decisão de acionar a concessionária de energia foi compatível com o risco elétrico descrito e o resumo reconheceu as faíscas e a obstrução da rua. A resposta foi formalmente válida e utilizou as informações da ocorrência.

Os dois cenários com áudio retornaram o código 404 e a mensagem `No endpoints found that support input audio`. Assim, o modelo não foi testado semanticamente nessas ocorrências, pois a integração não encontrou um endpoint que aceitasse essa modalidade.

Na análise complementar, o levantamento considerou o Muse Spark 1.2 como possível componente de percepção para produzir uma representação textual das entradas sonoras e visuais antes da classificação pelo Llama 4 Maverick. Essa composição é uma alternativa a investigar; sem resultados completos e métricas de suas etapas, não se pode afirmar que ela tenha superado experimentalmente as falhas dos cenários com áudio. 

=== Qwen 3.6 Plus

O Qwen 3.6 Plus também concluiu apenas os cenários sem áudio. No cenário textual, retornou “Polícia Militar / Rodoviária” e o número 190. A resposta reconheceu a necessidade de apoio para segurança, sinalização e remoção do veículo. Assim como ocorreu com o Claude, o nome do serviço reuniu órgãos distintos, enquanto o número fornecido correspondia apenas à Polícia Militar. A recomendação foi funcional, mas pouco precisa na identificação institucional.

No cenário de texto e imagem, o modelo recomendou o Corpo de Bombeiros, com o número 193. A resposta identificou corretamente a queda da árvore, o risco de choque e o bloqueio da via, sendo considerada adequada ao cenário.

Nos testes de áudio e de áudio com imagem, o OpenRouter retornou o código 404 com a mensagem `No endpoints found that support input audio`. A falha ocorreu, portanto, por incompatibilidade da rota de inferência com a modalidade sonora.

Na segunda análise, não foi identificado no OpenRouter um modelo do ecossistema Qwen capaz de receber áudio e convertê-lo em uma representação textual para o Qwen 3.6 Plus. Embora a família apresente outros modelos com recursos visuais, essa capacidade não soluciona a principal limitação observada, pois o modelo principal já processou satisfatoriamente texto e imagem. Dessa forma, a avaliação do ecossistema não ampliou a cobertura do Qwen, que permaneceu restrito aos dois cenários sem áudio. 

=== Gemini 3.5 Flash

O Gemini 3.5 Flash foi o único modelo que concluiu os quatro cenários e retornou os três campos exigidos em todas as respostas.

No cenário textual, recomendou a Polícia Militar, por meio do número 190, considerando o veículo parado, o anoitecer, a presença da pessoa idosa e a insegurança relatada. A escolha foi considerada coerente por evitar assumir que a via era necessariamente estadual ou federal.

No cenário de texto e imagem, indicou a Neoenergia Coelba e informou o número 116. O resumo identificou a árvore, os fios energizados, as faíscas e a obstrução da via. A resposta demonstrou integração entre o relato textual, a imagem e o contexto geográfico.

No cenário exclusivamente sonoro, o modelo identificou que o áudio relatava um gato atropelado e recomendou um hospital veterinário de Santo Antônio de Jesus. O conteúdo foi semanticamente compatível com a gravação e demonstrou processamento efetivo da fala. Entretanto, como o modelo apresentou um estabelecimento e um telefone locais específicos, essa informação deve ser verificada externamente antes de ser considerada factual. O #emph[benchmark] demonstra que o modelo produziu uma resposta contextualizada, mas não comprova, isoladamente, que o contato esteja atualizado.

No cenário composto por áudio e imagem, recomendou o Corpo de Bombeiros, pelo número 193, e descreveu a entrada de água na residência durante fortes chuvas. A resposta correspondeu às duas modalidades e ao contexto geográfico de Jequié.

Por apresentar suporte nativo às modalidades de texto, imagem e áudio, o Gemini 3.5 Flash não exigiu a utilização de modelos auxiliares na segunda análise. Os quatro cenários puderam ser processados diretamente pelo mesmo modelo, incluindo a combinação de áudio e imagem em uma única requisição. Dessa forma, seu ecossistema não precisou recorrer ao processamento sequencial, mantendo o fluxo de classificação mais simples entre as alternativas avaliadas. 

=== Nemotron 3 Nano Omni

O Nemotron produziu respostas nos três primeiros cenários, mas apresentou problemas importantes de interpretação.

No cenário textual, recomendou a Polícia Rodoviária Federal e informou o número 191. O resumo reconheceu o veículo parado, o período noturno e a presença de uma pessoa idosa. Contudo, assim como no Llama, a escolha da #abbrev("PRF") pressupôs que a ocorrência estivesse em rodovia federal, informação não fornecida no cenário. Por isso, a recomendação foi considerada apenas parcialmente adequada.

No cenário com texto e imagem, recomendou “Neoenergia” e apresentou o telefone 0800 01 5 5 200. Embora tenha reconhecido corretamente o risco elétrico, o número foi retornado com formatação incomum e não pôde ser considerado confiável apenas com base no #emph[benchmark]. O nome genérico da empresa também não especificou claramente a concessionária responsável pela região.

No cenário de áudio, a requisição foi tecnicamente aceita, diferentemente do que ocorreu com a maioria dos modelos. Entretanto, a resposta indicou a Polícia Militar, pelo número 190, e afirmou que a ocorrência não havia sido especificada. O áudio relatava um gato atropelado. Portanto, o modelo demonstrou compatibilidade técnica com o arquivo sonoro, mas não conseguiu compreender seu conteúdo. Esse resultado deve ser classificado como falha semântica, não como sucesso do cenário.

No cenário com áudio e imagem, o registro ficou vazio: não houve serviço, telefone, contexto, código de erro ou métricas. Isso indica que a execução não produziu um resultado aproveitável, mas o arquivo CSV não permite determinar se houve interrupção da chamada, falha na gravação do resultado ou retorno vazio do provedor.

Na análise complementar, foi considerada a possibilidade de separar percepção e classificação, utilizando o Nano Omni para extrair informações e outro modelo Nemotron para produzir a recomendação. A viabilidade foi classificada como condicional porque o erro observado ocorreu justamente na compreensão do áudio. A separação das tarefas não comprova a correção dessa interpretação e requer a avaliação das saídas intermediárias e da resposta final. 

=== North Mini Code

O North Mini Code concluiu apenas o cenário textual. A resposta recomendou a Polícia Militar, informou o número 190 e resumiu adequadamente o veículo parado, o anoitecer, a presença da passageira idosa e a insegurança. Embora simples, a resposta cumpriu a estrutura JSON exigida e foi considerada satisfatória para essa entrada.

No cenário com imagem, o OpenRouter retornou o código 404 e a mensagem No endpoints found that support image input. Essa mensagem demonstra explicitamente que nenhum endpoint disponível para aquela rota aceitava conteúdo visual.

O cenário exclusivamente sonoro retornou o código 404 com `No endpoints found that support input audio`. Já o cenário contendo áudio e imagem voltou a apresentar incompatibilidade com imagem. Dessa forma, o modelo demonstrou suporte apenas à entrada textual na integração utilizada.

O North apresentou baixo custo e tempo de resposta relativamente curto na única execução concluída. Entretanto, sua natureza voltada principalmente para tarefas de código e sua ausência de compatibilidade multimodal tornaram o modelo inadequado aos requisitos centrais da aplicação.

Na segunda análise, não foram identificados no OpenRouter modelos do ecossistema Cohere capazes de processar imagens ou áudios para complementar o North Mini Code. Por isso, não foi possível construir um fluxo com modelos auxiliares que convertesse essas entradas em conteúdo textual. A avaliação do ecossistema não ampliou sua cobertura, que permaneceu restrita ao cenário composto exclusivamente por texto. 

== Conclusão do Benchmarking

O desenvolvimento do Centro de Ajuda também ampliou a compreensão sobre o funcionamento de modelos multimodais em aplicações integradas por #abbrev("API"). Durante a implementação e a realização dos testes, foi possível identificar que a multimodalidade apresentada nas interfaces de conversação dos diferentes ecossistemas nem sempre corresponde às capacidades disponíveis diretamente em seus modelos ou endpoints.

Em alguns casos, as interfaces disponibilizadas pelos desenvolvedores combinam diferentes modelos e ferramentas para receber texto, áudio e imagem. Essa composição pode transmitir a impressão de que um único modelo processa todas as modalidades, embora parte do conteúdo seja tratada previamente por componentes especializados. Quando o modelo é acessado isoladamente por #abbrev("API"), essas funcionalidades podem não estar disponíveis na mesma requisição.

Essa diferença foi observada no #emph[benchmark] realizado por meio do OpenRouter. Entre os modelos avaliados isoladamente, apenas o Gemini 3.5 Flash processou diretamente texto, imagem e áudio nos quatro cenários. Os demais apresentaram diferentes níveis de compatibilidade, variando entre o suporte a texto e imagem, a limitação exclusiva ao texto e a aceitação técnica de arquivos sem a compreensão adequada de seu conteúdo.

A análise dos ecossistemas identificou possibilidades de contornar algumas dessas limitações pela execução sequencial de modelos especializados, sem comprovar o desempenho das composições. Nesse tipo de fluxo, um modelo pode interpretar determinada modalidade e encaminhar o conteúdo extraído ao modelo responsável pela classificação final. Portanto, a adoção de inteligência artificial em aplicações multimodais exige a verificação das capacidades efetivamente disponibilizadas pela #abbrev("API"), não sendo suficiente considerar apenas os recursos presentes nas interfaces de chat ou descritos de maneira geral para cada ecossistema.

= Conclusão

O Centro de Ajuda demonstrou viabilidade técnica inicial para interpretar relatos emergenciais e produzir recomendações estruturadas nas condições avaliadas. O servidor integrou entradas multimodais, geocodificação, prompts e OpenRouter para retornar os campos `service_name`, `phone_number` e `emergency_context`. O fluxo projetado da interface prevê o acesso ao discador por meio do esquema `tel:`, permanecendo a conclusão e a validação da aplicação cliente como etapas de continuidade.

== Avaliação dos Modelos

A avaliação realizada por meio do #emph[benchmark] permitiu observar diferenças importantes entre os modelos quanto à compatibilidade com texto, áudio e imagem, à geração de respostas estruturadas, à adequação das recomendações, ao tempo de processamento e ao custo. Entre os modelos avaliados, apenas o Gemini 3.5 Flash processou diretamente as entradas de texto, imagem e áudio nos quatro cenários propostos. Os demais apresentaram limitações de compatibilidade com uma ou mais modalidades, exigindo, para uma eventual utilização no sistema, o emprego de modelos especializados ou de etapas adicionais de processamento.
Os testes também demonstraram que a disponibilidade de uma modalidade depende não apenas das capacidades anunciadas para cada família, mas dos modelos e endpoints efetivamente acessíveis durante a integração. A análise dos ecossistemas complementou essa avaliação ao considerar a possibilidade de utilizar modelos especializados em diferentes etapas do processamento.

== Propostas Futuras

Embora os resultados obtidos tenham demonstrado a viabilidade da proposta, o Centro de Ajuda ainda possui possibilidades de aprimoramento antes de uma eventual utilização em situações reais. As propostas apresentadas a seguir envolvem a evolução técnica da aplicação, a ampliação do processo de avaliação, a investigação de outros modelos de linguagem e o desenvolvimento de mecanismos capazes de aumentar a confiabilidade das recomendações produzidas.

=== Aperfeiçoamento da aplicação

Como continuidade deste trabalho, a prova de conceito pode ser ampliada por meio da implementação completa da aplicação cliente e do aperfeiçoamento de aspectos relacionados à segurança, acessibilidade, desempenho e tratamento de falhas. Entre as possíveis melhorias estão a adoção de mecanismos de proteção dos dados enviados, a ampliação da compatibilidade com diferentes dispositivos e a inclusão de recursos de acessibilidade, como leitura de tela, comandos por voz, textos com maior contraste e formas alternativas de interação.
Também podem ser desenvolvidos recursos para funcionamento parcial em situações de conexão instável ou indisponível. Entre eles, destacam-se o armazenamento local de números oficiais, a apresentação de orientações básicas previamente cadastradas e a manutenção temporária das informações fornecidas pelo usuário até que a conexão seja restabelecida. Entretanto, qualquer armazenamento local de relatos, imagens, áudios ou dados de localização deverá considerar mecanismos de proteção e descarte seguro dessas informações.
No servidor, podem ser implementadas estratégias de repetição automática das requisições, definição de limites de tempo de resposta e seleção de modelos alternativos quando o serviço principal estiver indisponível. Também seria possível utilizar mecanismos de monitoramento para registrar falhas, identificar períodos de instabilidade e acompanhar o desempenho dos provedores utilizados pela aplicação.

=== Ampliação dos cenários de avaliação

A avaliação pode ser expandida com uma quantidade maior de cenários, abrangendo diferentes tipos de ocorrência, níveis de gravidade, localidades e serviços responsáveis pelo atendimento. Novos experimentos poderiam contemplar situações médicas, acidentes de trânsito, incêndios, desastres naturais, ocorrências policiais, violações de direitos e problemas relacionados a serviços públicos ou concessionárias.
Também podem ser incluídos relatos ambíguos, incompletos ou escritos com erros, além de áudios com ruídos, falas interrompidas, diferentes sotaques e baixa qualidade de gravação. No caso das imagens, seria relevante utilizar registros com pouca iluminação, baixa resolução, enquadramento inadequado ou elementos parcialmente ocultos. Outros cenários poderiam apresentar informações complementares ou contraditórias entre texto, áudio e imagem, permitindo analisar como cada modelo identifica e resolve possíveis divergências.
A repetição de cada cenário permitiria calcular médias e medidas de variação mais representativas para custo, tempo de resposta, consumo de #emph[tokens] e estabilidade. Dessa forma, seria possível reduzir a influência das condições específicas de uma única execução e produzir comparações mais consistentes entre os modelos avaliados. A realização dos testes em diferentes horários e períodos também poderia contribuir para identificar variações relacionadas à disponibilidade e à carga dos serviços em nuvem.

=== Avaliação de outros modelos

Trabalhos futuros também podem avaliar modelos menores ou executados localmente, como os pertencentes às famílias Llama, Gemma e Qwen. Essa abordagem permitiria investigar alternativas com menor custo de operação, maior controle sobre os dados processados e menor dependência de plataformas externas. A execução local também poderia ser útil em ambientes com restrições de conectividade ou com requisitos mais rigorosos de privacidade.
Entretanto, essa possibilidade exige a análise dos recursos computacionais necessários, do tempo de processamento e da capacidade de cada modelo para interpretar texto, áudio e imagem. Em alguns casos, pode ser necessário utilizar modelos especializados em conjunto, como um sistema para transcrição de áudio, outro para análise de imagens e um modelo de linguagem responsável pela classificação final da ocorrência.
Além disso, recomenda-se repetir o #emph[benchmark] utilizando os modelos mais modernos disponíveis no período em que as melhorias foram realizadas, considerando a rápida evolução das capacidades multimodais e das interfaces oferecidas pelos provedores. Essas avaliações deverão manter os mesmos cenários, critérios e estrutura de entrada sempre que possível, permitindo comparar os novos resultados com aqueles obtidos neste trabalho.

=== Validação das recomendações

Os resultados podem ser comparados com classificações de referência previamente definidas e avaliadas por profissionais com conhecimento nas áreas envolvidas. Essa validação permitiria verificar de maneira mais objetiva se o serviço recomendado, o número informado e o contexto apresentado corresponde adequadamente à ocorrência descrita.
A participação de profissionais ligados à saúde, segurança pública, defesa civil, assistência social e serviços municipais também poderia auxiliar na elaboração dos cenários e na definição dos critérios de avaliação. Além da identificação do órgão mais adequado, poderiam ser analisados aspectos como gravidade, urgência, clareza da justificativa e presença de recomendações potencialmente inadequadas ou perigosas.
A utilização contínua do sistema também poderia contribuir para a formação de uma base de dados com os números e órgãos identificados durante as solicitações, funcionando como um mecanismo de cache organizado por localização, área de atendimento e tipo de ocorrência. Quando um contato já estivesse armazenado e validado para determinado contexto, o sistema poderia utilizá-lo em solicitações posteriores, reduzindo a necessidade de novas pesquisas e a dependência das informações produzidas pelos modelos. Nesse funcionamento, o modelo seria empregado principalmente na interpretação e na classificação do relato, enquanto os dados de contato seriam recuperados da base. Para evitar a propagação de informações incorretas, a inclusão e a reutilização dos contatos deveriam ser acompanhadas por processos de validação em fontes oficiais, controle de validade e rotinas periódicas de verificação e atualização. 

== Considerações Finais

Dessa forma, os resultados obtidos indicam que o Centro de Ajuda é tecnicamente viável como uma ferramenta de apoio ao direcionamento de solicitações emergenciais. A avaliação demonstrou que os modelos de inteligência artificial podem interpretar as informações fornecidas e contribuir para a classificação e o direcionamento das ocorrências, embora sua utilização dependa da compatibilidade das interfaces, da validação dos contatos recomendados e da adoção de mecanismos para tratar erros e indisponibilidades.
A prova de conceito demonstrou o processamento no servidor, a integração com os serviços de localização e os modelos de inteligência artificial, além de apresentar o fluxo previsto para a interface. Esses resultados atendem ao recorte de viabilidade técnica investigado, sem comprovar a conclusão e a validação integral da aplicação cliente. Entretanto, a solução não deve ser compreendida como substituta das centrais oficiais ou da avaliação humana, mas como um recurso intermediário destinado a reduzir dúvidas e facilitar o acesso ao serviço considerado mais adequado.
Os resultados alcançados representam, portanto, uma etapa inicial do desenvolvimento da proposta. As possibilidades apresentadas para sua continuidade demonstram que o Centro de Ajuda ainda possui um amplo campo de evolução, tanto em sua implementação quanto na avaliação e na confiabilidade das recomendações. Assim, este trabalho estabelece uma base para novos estudos e aperfeiçoamentos que poderão aproximar a proposta de uma aplicação mais segura, abrangente e adequada a situações reais.

#references()

//#glossario()

//#apendice
//= Códigos Complementares
//Conteúdo adicional de implementação.

//#anexo
//= Portaria de Autorização
//Conteúdo do anexo A.
