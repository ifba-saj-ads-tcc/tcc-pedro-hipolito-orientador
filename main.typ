#import "ifbasaj-tcc/imports.typ": *
#show: template.with(
  titulo: "Centro de Ajuda: Sistema Inteligente de Redirecionamento de Comunicação em Situações Emergenciais",
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
  ficha-catalografica: image("assets/ficha-exemplo.pdf", width: 100%, height: 100%, fit: "contain"),
  bibliografia: read("referencias.bib"),
  versao-impressao: false,
)

= Introdução

O acionamento de serviços de emergência no Brasil ainda é marcado pela descentralização dos recursos públicos e privados, causando confusão pública, falhas de acesso, dentre outros fatores que comprometem a qualidade das respostas dos órgãos competentes. Este capítulo define o que é o número de emergência universal, qual tipo de problema é causado quando o serviço não é disponibilizado para a população, e como esse problema pode ser resolvido através de um aplicativo, especialmente quando a máquina pública não disponibiliza tais ferramentas.

== Justificativa

Para definir uma estratégia, primeiro é necessário entender os principais desafios que as motivam, nesse cenário, com ênfase às limitações enfrentadas pela população diante do baixo nível de preparo e acesso à informação.

=== O que é o número de emergência universal

Segundo #prose("mossEloise"), o número de emergência universal é, essencialmente, um identificador telefônico único criado para centralizar o acesso a qualquer tipo de urgência. Sua função é permitir que uma pessoa consiga, em qualquer situação crítica, acionar socorro imediato sem precisar distinguir qual órgão é responsável pelo atendimento. Em vez de vários números de emergência competindo por espaço, existe um ponto único centralizado capaz de encaminhar a chamada, através de informações atualizadas e localizadas, criando um canal simples, memorável e intuitivo. A autora descreve o número de emergência universal como um mecanismo que unifica a porta de entrada do sistema, reduzindo barreiras cognitivas, consequentemente facilitando o acionamento rápido e preciso do serviço.

De acordo com #prose("mossEloise"), diversos países adotaram modelos de números de emergência universal ao longo das décadas, estruturando sistemas nacionais centralizados de emergência que operam a partir de um único canal de acesso. O Reino Unido, por exemplo, implementou o número 999 como sistema nacional de emergência, enquanto os Estados Unidos consolidaram o uso do famoso 911 para o acionamento de polícia, bombeiros e serviços médicos. No entanto, a implementação dessa ferramenta não ocorreu de forma uniforme em todos os países, existindo diferenças estruturais, tecnológicas e administrativas que impactaram a possibilidade de integração dos serviços unificados de emergência #cite("mossEloise").

=== Números de emergência no Brasil

No ambiente brasileiro, o atendimento emergencial permanece distribuído entre diversos diferentes números especializados, cada um associado a um órgão que socorre tipos específicos de ocorrência. Entre os principais exemplos estão o 190, destinado ao acionamento da Polícia Militar em situações de violência, crimes e ameaças à segurança pública; o 192, responsável pelo Serviço de Atendimento Móvel de Urgência (SAMU), voltando para emergências médicas; e o 193, destinado ao Corpo de Bombeiros para casos de incêndios, acidentes e resgates. Esse modelo fragmentado busca especializar o atendimento conforme a natureza da ocorrência, concluindo que o cidadão possui plena consciência da existência de múltiplos números de emergência #cite("anatel2025").

De acordo com a pesquisa de #prose("revistaUnijui2024"), a fragmentação dos números de emergência brasileiros ainda gera dificuldades significativas no reconhecimento e diferenciação dos serviços pela população brasileira. O estudo publicado identificou que, embora o número 190 apresente alto índice de reconhecimento correto (92.2%), há considerável confusão em relação às atribuições do SAMU (192) e do Corpo de Bombeiros (193), que apresentaram índices de reconhecimento correto de apenas 72.6% e 70.8%, respectivamente. Além disso, o estudo aponta que 23% dos entrevistados associaram incorretamente o número 192 ao Corpo de Bombeiros, enquanto 24.2% relacionaram equivocadamente o número 193 ao SAMU. A pesquisa conclui que parte da população não consegue diferenciar adequadamente os serviços disponíveis, especialmente em situações de estresse, o que pode retardar o acionamento do socorro adequado, consequentemente agravando a ocorrência. Os autores apontam que a unificação dos núcleos de atendimento é uma forte possibilidade para reduzir dúvidas e simplificar o acesso aos serviços emergenciais.

== Objetivo

Devido à existência de múltiplos números de emergência no Brasil e às dificuldades da população em diferenciar corretamente os serviços responsáveis por cada tipo de ocorrência, o presente trabalho tem como objetivo desenvolver uma prova de conceito de um sistema inteligente de redirecionamento de comunicação em situações emergenciais, denominado #emph[Centro de Ajuda]. A proposta consiste em uma aplicação móvel, integrada a um servidor responsável pelo processamento das solicitações realizadas pelos usuários.

A solução permite que o usuário envie relatos em formato textual, sonoro ou visual descrevendo a situação enfrentada, possibilitando que uma inteligência artificial interprete o contexto da ocorrência e forneça informações relevantes sobre qual órgão ou serviço de emergência deve ser acionado. O sistema busca atuar como uma camada intermediária de apoio à decisão, reduzindo dúvidas relacionadas aos números emergenciais e auxiliando no direcionamento adequado da solicitação à entidade final.

A lógica do projeto atribui à inteligência artificial a responsabilidade de analisar a situação utilizando diferentes dados contextuais, como localização geográfica, data, horário e descrição da ocorrência. A partir dessas informações, o sistema pode interpretar características regionais, buscar notícias com informações relevantes, compreender o contexto da emergência e identificar quais serviços possuem maior compatibilidade com a situação relatada. Dessa forma, busca-se reduzir ambiguidades no acionamento dos serviços emergenciais e melhorar a acessibilidade ao atendimento adequado.

O fluxo geral de interação entre usuário, servidor e inteligência artificial pode ser visualizado na @fig:diagrama_introducao_objetivo_interacao.

#figura(
  image("assets/imagens/diagrama-introducao.png", width: 90%),
  caption: [Fluxo de interação entre usuário, servidor e inteligência artificial],
) <fig:diagrama_introducao_objetivo_interacao>

=== Objetivos Específicos

Com esse objetivo definido, este trabalho consiste em desenvolver uma aplicação móvel capaz de permitir o envio de relatos emergenciais em formato textual, sonoro e visual; implementar um servidor responsável pelo recebimento, processamento e gerenciamento das informações enviadas pelos usuários; integrar modelos de inteligência artificial para interpretação contextual das ocorrências relatadas; utilizar dados complementares, como localização geográfica, data e horário, para auxiliar na análise contextual das emergências; identificar e recomendar o órgão ou serviço de emergência mais adequado para cada situação reportada; reduzir ambiguidades relacionadas à diferenciação dos números de emergência existentes no Brasil; avaliar a viabilidade da utilização de inteligência artificial como ferramenta de apoio ao redirecionamento de solicitações emergenciais; e desenvolver uma prova de conceito funcional capaz de demonstrar o fluxo completo de comunicação entre usuário, servidor e sistema inteligente.

== Correlatos

Para justificar a proposta apresentada anteriormente, torna-se necessário compreender o estado atual das tecnologias e sistemas relacionados ao atendimento emergencial. No cenário contemporâneo, é possível identificar tanto iniciativas privadas desenvolvidas com o objetivo de complementar limitações estruturais dos sistemas públicos de emergência, quanto modelos públicos integrados criados para centralizar e otimizar o acionamento de serviços emergenciais. Essas soluções buscam reduzir o tempo de resposta, melhorar a disponibilidade de informações contextuais e aumentar a eficiência na comunicação entre cidadãos e órgãos responsáveis pelo socorro.

=== RapidSOS

Representando a iniciativa privada, o RapidSOS consiste em uma plataforma voltada para integração tecnológica entre dispositivos móveis e centrais de atendimento emergencial. A solução foi desenvolvida com o objetivo de fornecer informações adicionais durante chamadas de emergência, permitindo que operadores tenham acesso a dados como localização, informações médicas e vídeos. A proposta da plataforma busca reduzir limitações em sistemas tradicionais de emergência, aumentando a disponibilidade de informações para as equipes responsáveis pelo atendimento e resposta às ocorrências #cite("rapidSOS2025").

Apesar de ampliar a quantidade de dados disponíveis para os operadores, o RapidSOS não possui foco direto na interpretação automatizada da situação enfrentada pelo usuário através de inteligência artificial voltada ao redirecionamento contextual da ocorrência. Sua atuação está concentrada principalmente no compartilhamento de dados entre dispositivos e centrais emergenciais #cite("rapidSOS2025").

A relação entre o RapidSOS e a proposta deste trabalho encontra-se principalmente na utilização de dados contextuais para auxiliar situações emergenciais. Ambos utilizam informações contextuais como localização geográfica, horário e descrição da ocorrência para auxiliar no direcionamento adequado da solicitação emergencial.

=== 911 e 112

Representando modelos públicos integrados de emergência, os sistemas 911 e 112 constituem alguns dos principais exemplos de números universais de emergência utilizados internacionalmente. O número 911 é amplamente utilizado nos Estados Unidos e Canadá como canal centralizado para acionamento de polícia, bombeiros e serviços médicos emergenciais, enquanto o 112 foi adotado como número padrão de emergência em diversos países da União Europeia #cite("nena911", "eena112").

Esses modelos possuem como principal característica a centralização do acesso aos serviços emergenciais através de um único número telefônico, reduzindo ambiguidades relacionadas à identificação do órgão responsável pela ocorrência. Além disso, sistemas modernos baseados em 911 e 112 passaram a incorporar recursos tecnológicos complementares, como compartilhamento automático de localização, integração digital entre centrais, suporte a comunicação multimodal e encaminhamento inteligente de chamadas #cite("nena911", "eena112").

Embora apresentem elevado nível de integração estrutural, esses sistemas dependem diretamente da infraestrutura pública de emergência existente em cada país, além de exigirem elevado nível de padronização tecnológica e administrativa para seu funcionamento eficiente. A relação entre esses sistemas e a proposta deste trabalho encontra-se principalmente na tentativa de centralizar e simplificar o acesso aos serviços emergenciais, reduzindo dificuldades relacionadas à identificação do órgão responsável pela ocorrência. Entretanto, diferentemente dos modelos tradicionais de 911 e 112, o projeto Centro de Ajuda propõe a utilização de inteligência artificial para interpretar contextualmente a situação relatada pelo usuário antes do direcionamento emergencial.


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

Dessa forma, o termo #emph[deep learning], também conhecido como aprendizado profundo, refere-se à utilização de redes neurais compostas por múltiplas camadas ocultas. O aumento da profundidade dessas arquiteturas permitiu avanços significativos no desempenho de modelos de inteligência artificial, especialmente em aplicações envolvendo grandes volumes de dados. Diferentemente de métodos tradicionais, nos quais características relevantes precisavam ser definidas manualmente, modelos de aprendizado profundo conseguem aprender automaticamente representações internas diretamente a partir dos dados utilizados durante o treinamento.

Eventualmente, diferentes arquiteturas de redes neurais passaram a ser desenvolvidas para resolver problemas específicos. Entre os principais exemplos estão as redes neurais convolucionais (#abbrev("CNNs", long: "Convolutional Neural Networks")amplamente utilizadas em tarefas de visão computacional e reconhecimento de imagens, e as redes neurais recorrentes (#abbrev("RNNs", long:"Recurrent Neural Networks")) desenvolvidas para lidar com dados sequenciais, como textos e traduções automáticas #cite("goodfellow2016").

Segundo #prose("goodfellow2016"), as redes neurais recorrentes possuem a capacidade de manter informações relacionadas a estados anteriores durante o processamento da sequência, permitindo que o modelo considere o contexto de elementos previamente analisados. Essa característica tornou as RNNs uma das principais abordagens utilizadas nas primeiras aplicações modernas de processamento de linguagem natural, reconhecimento de fala e tradução automática.

Apesar de representarem um avanço significativo em relação a modelos tradicionais, arquiteturas recorrentes apresentavam limitações relacionadas à dificuldade de processamento paralelo e à perda de informações em sequências muito longas, problema conhecido como #emph[vanishing gradient]. Essas limitações impulsionaram o desenvolvimento de arquiteturas mais eficientes para interpretação contextual e processamento de grandes volumes de dados sequenciais #cite("goodfellow2016").

=== Arquitetura Transformer

Diferente de arquiteturas anteriores, como #abbrev("RNNs"), Transformer foi desenvolvido com o objetivo de processar informações de maneira paralela, reduzindo limitações relacionadas à dependência sequencial dos dados. Enquanto modelos recorrentes analisavam palavras e informações uma após a outra, a arquitetura Transformer passou a processar sequências inteiras simultaneamente, aumentando significativamente a eficiência computacional e a capacidade de treinamento em grandes conjuntos de dados #cite("vaswani2017").

O principal componente responsável pelo funcionamento desta arquitetura é o mecanismo de atenção, especialmente o chamado #emph[self-attention].  Esse mecanismo permite que o modelo avalie a relevância de diferentes elementos de uma sequência em relação aos demais elementos presentes no mesmo contexto. Dessa forma, o Transformer consegue compreender relações semânticas entre palavras, identificar dependências contextuais distantes e interpretar significados de maneira mais consistente #cite("vaswani2017").

Segundo #prose("vaswani2017"), Outra vantagem substancial da arquitetura Transformer é sua escalabilidade. O modelo demonstrou elevada capacidade de desempenho conforme aumentavam o volume de dados utilizados durante o treinamento e a quantidade de parâmetros presentes na rede neural. Essa característica contribuiu diretamente para o desenvolvimento de modelos modernos capazes de realizar tarefas complexas de interpretação contextual, geração de texto e raciocínio baseado em linguagem natural.

== LLMs

A elevada escalabilidade da arquitetura Transformer possibilitou o desenvolvimento dos chamados modelos de linguagem de grande porte (#abbrev("LLMs", long: "Large Language Models")). Esses modelos consistem em redes neurais treinadas em enormes volumes de dados textuais com o objetivo de identificar padrões estatísticos, relações semânticas e estruturas linguísticas presentes na linguagem humana..

Segundo #prose("brown2020"), os #abbrev("LLMs") são capazes de aprender relações contextuais complexas entre palavras, frases e conceitos por meio do treinamento em grandes conjuntos de dados. Durante esse processo, os textos são divididos em tokens, que representam palavras completas ou fragmentos de palavras. Esses tokens são convertidos em representações numéricas de alta dimensão, permitindo que o modelo analise matematicamente relações de proximidade e contexto entre diferentes elementos linguísticos.

Com base nessas relações estatísticas, os modelos conseguem calcular a probabilidade de um token suceder outro dentro de uma sequência textual. Esse processo permite que LLMs realizem tarefas como geração de texto, tradução automática, sumarização, interpretação contextual e respostas baseadas em linguagem natural. Quanto maior o volume de dados e a quantidade de parâmetros utilizados durante o treinamento, maior tende a ser a capacidade do modelo em compreender contextos complexos e produzir respostas coerentes #cite("brown2020").

=== Engenharia de Prompt

Para se comunicar com #abbrev("LLMs"), é necessário fornecer instruções textuais conhecidas como prompts. Segundo #prose("openAIPromptGuide"), prompts consistem em instruções textuais utilizadas para orientar o comportamento do modelo durante a geração de respostas. Essas instruções podem incluir contexto adicional, regras de comportamento, exemplos de entrada e saída, restrições de formato e descrições detalhadas sobre a tarefa desejada. Quanto mais claro e contextualizado for o prompt, maior tende a ser a capacidade do modelo em produzir resultados coerentes com o objetivo esperado.

Essa interpretação contextual desempenha papel fundamental no funcionamento dos LLMs. Palavras isoladas podem possuir múltiplos significados dependendo do contexto em que aparecem. O termo banco, por exemplo, pode se referir tanto a uma instituição financeira quanto a um objeto utilizado para sentar. Nesse cenário, os modelos utilizam relações estatísticas aprendidas durante o treinamento para analisar palavras vizinhas, estruturas semânticas e padrões linguísticos capazes de indicar qual significado possui maior probabilidade dentro daquele contexto específico #cite("openAIPromptGuide"). Dessa forma, a maneira como as informações são apresentadas no prompt influencia diretamente a interpretação realizada pelo modelo.

Para orientar essa interpretação, diferentes técnicas de engenharia de prompt podem ser empregadas. Entre elas estão o #emph[zero-shot], no qual o modelo executa uma tarefa apenas com base na instrução fornecida; o #emph[few-shot] que apresenta exemplos de entrada e saída para demonstrar o comportamento esperado; e o #emph[chain-of-thought] que orienta a decomposição de problemas complexos em etapas intermediárias de raciocínio. Por exemplo, para classificar uma emergência, o prompt pode apenas solicitar a classificação (#emph[zero-shot]), apresentar relatos previamente classificados (#emph[few-shot]) ou solicitar que os elementos da ocorrência sejam analisados antes da resposta final (#emph[chain-of-thought]) #cite("wei2022").

Embora essas técnicas contribuam para orientar o modelo e tornar suas respostas mais previsíveis, elas não eliminam as limitações inerentes aos LLMs. Pequenas alterações na estrutura textual da instrução podem gerar respostas significativamente diferentes, especialmente em tarefas complexas ou ambíguas. Além disso, modelos de linguagem podem produzir informações incorretas, fenômeno frequentemente chamado de  #emph[hallucination] no qual o sistema gera conteúdos sintaticamente coerentes, porém factualmente incorretos ou inexistentes  #cite("openAIPromptGuide").

Devido a essas características, a construção de prompts tornou-se uma etapa essencial no desenvolvimento de aplicações baseadas em inteligência artificial generativa. Estratégias como definição explícita de contexto, utilização de exemplos, delimitação de regras e restrição de formato são frequentemente utilizadas para aumentar a previsibilidade das respostas produzidas pelos modelos  #cite("openAIPromptGuide").

== Modelos Multimodais

A evolução dos modelos de linguagem de grande porte também possibilitou o desenvolvimento dos chamados modelos multimodais, sistemas de inteligência artificial capazes de processar e interpretar múltiplos tipos de dados simultaneamente. Diferentemente de modelos tradicionais voltados exclusivamente para uma única modalidade de entrada, esses sistemas são treinados utilizando diferentes formas de informação, como linguagem natural, imagens, áudio e vídeo  #cite("openAIGPT4").

Tais modelos possuem a capacidade de integrar diferentes modalidades em uma mesma representação contextual, permitindo compreender relações entre informações textuais, visuais e sonoras presentes nos dados analisados. Como resultado, essa abordagem amplia significativamente a capacidade interpretativa da inteligência artificial, tornando possível a execução de tarefas mais complexas que envolvem múltiplos formatos de informação #cite("openAIGPT4").

Segundo #prose("openAIGPT4"),  o funcionamento desses modelos geralmente ocorre através da conversão das diferentes modalidades em representações numéricas compatíveis dentro do espaço vetorial utilizado pela rede neural. Dessa forma, textos, imagens, sons e vídeos podem ser processados conjuntamente pelo modelo, permitindo que relações contextuais entre diferentes tipos de informação sejam identificadas durante a inferência.

A utilização de arquiteturas multimodais tornou-se especialmente relevante em aplicações modernas relacionadas à análise de imagens, reconhecimento de fala, interpretação audiovisual e assistentes inteligentes capazes de compreender diferentes formatos de entrada simultaneamente. Além disso, esses modelos passaram a demonstrar capacidade de realizar tarefas cruzadas entre modalidades, como descrever imagens em linguagem natural, responder perguntas sobre conteúdos visuais e interpretar informações sonoras contextualizadas  #cite("openAIGPT4").

=== Processamento de Imagem

Diferente de LLMs tradicionais voltadas exclusivamente para linguagem natural, os modelos multimodais possuem a capacidade de interpretar conteúdos visuais e relacioná-los ao contexto textual fornecido pelo usuário. Essa capacidade ampliou significativamente o potencial de aplicações baseadas em inteligência artificial, especialmente em cenários nos quais informações visuais desempenham papel importante para compreensão da situação analisada. Modelos multimodais modernos conseguem identificar objetos, interpretar cenas, reconhecer padrões visuais e responder perguntas relacionadas ao conteúdo presente em imagens, permitindo que informações textuais e visuais sejam analisadas conjuntamente durante a inferência  #cite("openAIGPT4").

Segundo #prose("openAIGPT4"), o funcionamento do processamento visual nesses modelos ocorre através da conversão dos elementos presentes na imagem em representações numéricas compatíveis com o espaço vetorial utilizado pela rede neural. Durante esse processo, características como formas, cores, texturas, objetos e relações espaciais são transformadas em #emph[embeddings] (representações vetoriais que preservam informações semânticas e estruturais dos dados) capazes de serem interpretados juntamente com dados textuais e contextuais. Dessa forma, o modelo consegue estabelecer relações semânticas entre diferentes modalidades de entrada, permitindo interpretação contextual integrada entre imagem e linguagem natural.

O processamento de imagens em modelos multimodais possui forte relação com técnicas de visão computacional #abbrev("RNNs")  anteriormente citados no documento. Segundo #prose("goodfellow2016"), arquiteturas convolucionais foram desenvolvidas especificamente para identificar padrões visuais em imagens através da aplicação sucessiva de filtros matemáticos capazes de reconhecer características progressivamente mais complexas. Em camadas iniciais, o modelo pode identificar bordas, linhas e texturas simples, enquanto camadas mais profundas conseguem reconhecer objetos completos, estruturas e relações contextuais presentes na cena analisada.

Embora modelos multimodais modernos não dependam exclusivamente de CNNs tradicionais, muitas arquiteturas atuais ainda utilizam princípios derivados do aprendizado profundo aplicado à visão computacional para interpretar informações visuais. Em sistemas baseados em Transformers multimodais, por exemplo, imagens podem ser divididas em pequenas regiões chamadas #emph[patches], que são convertidas em tokens visuais semelhantes aos tokens textuais utilizados em modelos de linguagem natural. Dessa forma, o modelo consegue aplicar mecanismos de atenção contextual também sobre elementos visuais da imagem #cite("dosovitskiy2021").

=== Processamento de Áudio

O processamento de áudio em modelos multimodais permite que sistemas interpretem informações sonoras e relacionem esses dados ao contexto textual e visual. Segundo #prose("whisper2022"), sistemas modernos de processamento de áudio convertem sinais sonoros em representações numéricas adequadas ao processamento por redes neurais.

Grande parte das aplicações contemporâneas utiliza técnicas de reconhecimento automático de fala (#emph[Automatic Speech Recognition] – ASR) #cite("whisper2022").

As primeiras aplicações modernas de reconhecimento de fala utilizaram fortemente arquiteturas recorrentes #cite("goodfellow2016").

=== Processamento de Vídeo

O processamento de vídeo em modelos multimodais envolve a análise simultânea de informações visuais e temporais #cite("openAIGPT4"). Arquiteturas modernas baseadas em Transformers multimodais demonstraram elevado desempenho nesse domínio #cite("vaswani2017").

// ========== METODOLOGIA ==========
= Metodologia

A metodologia utilizada neste trabalho consiste na análise de requisitos para o desenvolvimento de uma prova de conceito funcional de um sistema inteligente voltado ao auxílio no redirecionamento de solicitações emergenciais. O sistema foi estruturado utilizando arquitetura cliente-servidor.

== Critérios de Escolha para o(s) Modelo(s) LLM

O funcionamento da proposta depende diretamente da integração entre o servidor backend e modelos de inteligência artificial. Foram definidos critérios técnicos: capacidade multimodal (texto, áudio, imagem), disponibilidade em nuvem e capacidade de pesquisa na internet.

Entre os modelos analisados destacam-se o GPT-5.5, Claude Opus 4.8, Gemini 3.5 Flash, Llama 4 Maverick, Qwen 3.6 Plus, Nemotron 3 Nano Omni 30B e North Mini Code. As informações correspondem à análise realizada em 10 de junho de 2026.

A partir dos critérios estabelecidos, foi elaborada uma comparação preliminar entre os modelos selecionados.

#tabela(
  caption: [Comparação de modelos quanto aos critérios técnicos],
  columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  align: center,
  header: ([Critério], [GPT], [Claude], [Llama], [Qwen], [Gemini], [Nemotron], [North]),
  [Multimodal], [Parcial], [Parcial], [Parcial], [Parcial], [Sim], [Parcial], [Não],
  [Nuvem], [Sim], [Sim], [Sim], [Sim], [Sim], [Sim], [Sim],
  [Pesquisa], [Sim], [Sim], [Sim], [Sim], [Sim], [Não], [Não],
) <tab:criterios-llm>

=== GPT-5.5

O GPT-5.5, desenvolvido pela OpenAI, foi selecionado para análise #cite("gpt55"). Em relação à multimodalidade, o GPT-5.5 oferece suporte ao processamento de texto, imagens e áudio por meio da plataforma da OpenAI, porém sem envio simultâneo nativo das três modalidades em uma única solicitação, atendendo parcialmente ao critério #cite("gpt55"). É disponibilizado via APIs em nuvem #cite("gpt55") e oferece suporte à pesquisa na internet #cite("gpt55").

=== Claude Opus 4.8

Desenvolvido pela Anthropic, o Claude Opus 4.8 aceita texto e imagens, mas não áudio nativo, atendendo parcialmente ao critério #cite("claude48"). É disponibilizado via APIs em nuvem #cite("claude48") e disponibiliza recursos de pesquisa na internet #cite("claude48").

=== Llama 4 Maverick

O Llama 4 Maverick, desenvolvido pela Meta, oferece suporte a texto e imagens, sem áudio nativo #cite("llama4maverick"). É disponibilizado em nuvem #cite("llama4api") e pode ser integrado a ferramentas externas de busca #cite("llama4maverick").

=== Qwen 3.6 Plus

O Qwen 3.6 Plus, desenvolvido pela Alibaba Cloud, disponibiliza texto e imagens, sem áudio nativo #cite("qwenAPI"). Foi projetado para correlacionar texto e imagens #cite("qwenVL"). É acessível via nuvem #cite("qwenAPI") e permite integração com busca externa #cite("qwenAPI").

=== Gemini 3.5 Flash

O Gemini 3.5 Flash, desenvolvido pela Google, oferece suporte nativo a texto, imagens, áudio, vídeo e documentos, atendendo integralmente ao critério #cite("gemini35flash"). É disponibilizado via APIs em nuvem #cite("geminiAPI") e disponibiliza pesquisa nativa na internet #cite("gemini35flash").

=== Nemotron 3 Nano Omni

O Nemotron 3 Nano Omni 30B, desenvolvido pela NVIDIA, aceita texto, imagens, áudio e vídeo #cite("nemotron3nano"). Foi projetado para raciocínio conjunto multimodal #cite("nemotron3nano"). É disponibilizado via NVIDIA NIM em nuvem #cite("nemotron3nano") e não possui busca nativa, mas permite integração externa #cite("nemotron3nano").

=== North Mini Code

O North Mini Code, desenvolvido pela Cohere, foi desenvolvido essencialmente para texto e código, sem suporte nativo a imagens ou áudio #cite("northMiniCode"). Não atende ao requisito multimodal #cite("northMiniCode"). É disponibilizado sob licença Apache 2.0 em nuvem #cite("northMiniCode") e não possui busca nativa #cite("northMiniCode").

== Requisitos do Frontend

O frontend corresponde à camada responsável pela interação direta com o usuário. Foram identificadas três áreas fundamentais: interface do usuário, compatibilidade multiplataforma e comunicação cliente-servidor.

=== Interface do Usuário

A construção da interface foi realizada utilizando HTML, CSS e JavaScript #cite("mozillaMDN"). O HTML foi empregado para estruturar semanticamente a interface, o CSS para apresentação e o JavaScript para lógica e comunicação com o backend.

=== Compatibilidade Multiplataforma

A compatibilidade multiplataforma é proporcionada pela utilização de tecnologias web. Além disso, a aplicação pode ser disponibilizada como uma #emph[Progressive Web App] (PWA) #cite("mozillaPWA").

=== Comunicação Cliente-Servidor

A comunicação entre frontend e backend foi implementada utilizando a API Fetch #cite("mozillaFetch").

#figura(
  image("assets/imagens/fetch-api.png", width: 80%),
  caption: [Fluxo da API Fetch com Promise],
) <fig:fetch-api>

== Requisitos do Backend

O backend concentra o processamento necessário para transformar os dados enviados pelo usuário em resposta utilizável. Essa camada cumpre quatro funções: receber solicitações multimodais, complementar com localização, encaminhar ao LLM e devolver resposta estruturada.

=== Infraestrutura Backend

A infraestrutura foi construída como aplicação web organizada em torno de uma rota principal de atendimento. Foram utilizados Node.js, Express e Fetch #cite("nodeJS", "expressJS", "mozillaFetch").

=== Ambiente de Execução

O backend foi implementado em Node.js #cite("nodeJS"). O modelo assíncrono do Node.js foi especialmente relevante para aguardar serviços externos sem bloquear a execução.

=== Estrutura da Aplicação

Sobre o ambiente Node.js, o Express foi utilizado para criar a interface HTTP #cite("expressJS"). Quando uma requisição é recebida, o Express direciona os dados para a função responsável e verifica coordenadas geográficas.

=== Integração com Serviços Externos

As chamadas foram implementadas com a API Fetch #cite("mozillaFetch"). Uma integração ocorre com o serviço de geocodificação reversa do Google Maps e outra com a plataforma de distribuição de IAs.

== Fluxo de Comunicação

O fluxo inicia-se quando o frontend envia relato em texto, áudio ou imagem com coordenadas. O backend realiza geocodificação reversa, compõe contexto com horário e relato, envia à LLM e retorna serviço indicado, número e resumo. A sequência completa pode ser observada na @fig:diagrama_metodologia_backend.

#figura(
  image("assets/imagens/fluxo-backend.png", width: 90%),
  caption: [Fluxo de comunicação entre frontend, backend e APIs externas],
) <fig:diagrama_metodologia_backend>

// ========== DESENVOLVIMENTO ==========
= Desenvolvimento

Neste capítulo são apresentados os detalhes de desenvolvimento do sistema Centro de Ajuda.

== Abordagem Geral

O desenvolvimento foi dividido em duas camadas: aplicação cliente e aplicação servidora. O foco concentrou-se na implementação do backend e na validação do fluxo completo. O cliente móvel foi representado por protótipo funcional no Figma.

== Implementação da Aplicação Cliente

A aplicação cliente foi projetada para dispositivos móveis e organizada em módulos responsáveis pela interface, captura de entradas e envio ao servidor.

=== Arquitetura do Cliente

A arquitetura foi organizada de acordo com o fluxo de interação, abrangendo coleta, preparação, comunicação e apresentação do resultado, conforme @fig:diagrama_desenvolvimento_frontend_arquitetura.

#figura(
  image("assets/imagens/arquitetura-cliente.png", width: 90%),
  caption: [Arquitetura da aplicação cliente],
) <fig:diagrama_desenvolvimento_frontend_arquitetura>

=== Tecnologias da Aplicação Cliente

A interface foi desenvolvida com HTML5, CSS3 e JavaScript, com Bootstrap para responsividade. A comunicação utiliza Fetch API. A aplicação foi implementada como PWA básica com `manifest.json` e Service Worker.

=== Tela Inicial

A tela inicial concentra todas as funcionalidades para registro da ocorrência, conforme @fig:diagrama_desenvolvimento_frontend_entrada.

#figura(
  image("assets/imagens/tela-inicial.svg", width: 70%),
  caption: [Tela inicial do Centro de Ajuda],
) <fig:diagrama_desenvolvimento_frontend_entrada>

==== Captura de texto

A entrada textual foi implementada via `<textarea>` com limite de 2000 caracteres.

#codigo(
  lang: "html",
  caption: [Campo de texto da ocorrência],
  filename: "occurrence.html",
  read("assets/codigos/occurrence.html"),
) <code:textarea>

#codigo(
  lang: "javascript",
  caption: [Captura de texto via DOM],
  filename: "capture.js",
  read("assets/codigos/capture.js"),
)

==== Captura de áudio

A captura de áudio foi implementada com MediaDevices API e MediaRecorder API.

#codigo(
  lang: "javascript",
  caption: [Solicitação de acesso ao microfone],
  filename: "audio.js",
  read("assets/codigos/audio.js"),
)

#codigo(
  lang: "javascript",
  caption: [Gravação de áudio com MediaRecorder],
  filename: "recorder.js",
  read("assets/codigos/recorder.js"),
)

==== Captura de imagens

Campo de seleção com `capture="environment"` e preview via FileReader.

#codigo(
  lang: "javascript",
  caption: [Captura de imagem],
  filename: "image.js",
  read("assets/codigos/image.js"),
)

==== Envio da solicitação

#codigo(
  lang: "javascript",
  caption: [Envio da ocorrência ao servidor],
  filename: "submit.js",
  read("assets/codigos/submit.js"),
)

=== Tela de Espera

Após o envio, a aplicação apresenta tela de espera com animação de carregamento até retorno do servidor, conforme @fig:tela_espera.

#figura(
  image("assets/imagens/tela-espera.png", width: 70%),
  caption: [Tela de espera],
) <fig:tela_espera>

=== Tela de Resposta

A tela exibe serviço recomendado, telefone e resumo do contexto, conforme @fig:diagrama_desenvolvimento_frontend_resultado.

#figura(
  image("assets/imagens/tela-resultado.png", width: 70%),
  caption: [Tela de resposta com recomendação],
) <fig:diagrama_desenvolvimento_frontend_resultado>

#codigo(
  lang: "javascript",
  caption: [Tratamento da resposta do servidor],
  filename: "handle.js",
  read("assets/codigos/handle.js"),
)

#codigo(
  lang: "javascript",
  caption: [Redirecionamento para ligação],
  filename: "call.js",
  read("assets/codigos/call.js"),
)

== Implementação do Servidor

O servidor foi estruturado de forma modular (inicialização, rotas, processamento, serviços externos). Inicialização na porta 27020 com Express e CORS.

#codigo(
  lang: "javascript",
  caption: [Inicialização do servidor],
  filename: "main.js",
  read("assets/codigos/server.js"),
)

#codigo(
  lang: "javascript",
  caption: [Configuração Express com CORS e bodyParser],
  filename: "express.js",
  read("assets/codigos/express.js"),
)

#codigo(
  lang: "javascript",
  caption: [Geocodificação reversa],
  filename: "geocode.js",
  read("assets/codigos/geocode.js"),
)

Endpoints carregados dinamicamente do diretório `endpoints/` (ex.: `help.js` → `/help`). Comunicação com Google Reverse Geocoding e plataforma de IAs via Fetch, com conversão Base64 para multimodal.

== Construção do Prompt

Antes da comunicação com o LLM, o servidor constrói três componentes: System Prompt (regras, formato JSON), Assistant Prompt (contexto dinâmico: horário, endereço via `assistantprompt(context)`) e mensagem do usuário (texto + imagem Base64 + áudio Base64). Essa separação reduz acoplamento e permite alterar regras sem afetar contexto.

#codigo(lang: "javascript", caption: [System Prompt], filename: "systemprompt.js", read("assets/codigos/systemprompt.js"))
#codigo(lang: "javascript", caption: [Assistant Prompt contextual], filename: "assistantprompt.js", read("assets/codigos/assistantprompt.js"))
#codigo(lang: "javascript", caption: [Montagem conteúdo multimodal], filename: "multimodal.js", read("assets/codigos/multimodal.js"))

=== Formato de Saída (JSON)

O System Prompt exige resposta exclusivamente em JSON com `service_name`, `phone_number` e `emergency_context`. O servidor valida esses campos antes de encaminhar ao cliente, retornando erro 500 se inválido.

== Integração com Modelos de Linguagem

Utilizou-se o OpenRouter como gateway unificado. Comunicação via `POST https://openrouter.ai/api/v1/chat/completions` com `model: online`, `stream: false` e autenticação `Bearer OPENROUTERAPIKEY` via `dotenv`. São registrados `response_time_ms`, tokens e `cost` para benchmark.

#codigo(lang: "javascript", caption: [Chamada OpenRouter], filename: "openrouter.js", read("assets/codigos/openrouter.js"))
#codigo(lang: "javascript", caption: [Tratamento resultado e validação JSON], filename: "result.js", read("assets/codigos/result.js"))

A arquitetura completa (cliente → `/help` → geocodificação/prompt → OpenRouter → validação) centraliza credenciais no backend e permite trocar modelo sem alterar o frontend, conforme @fig:arquitetura-geral.

#figura(image("assets/imagens/arquitetura-geral.png", width: 90%), caption: [Arquitetura geral do sistema]) <fig:arquitetura-geral>

= Análise dos Resultados

Com a prova de conceito desenvolvida, avaliou-se o comportamento dos sete modelos (GPT-5.5, Claude Opus 4.8, Llama 4 Maverick, Qwen 3.6 Plus, Gemini 3.5 Flash, Nemotron 3 Nano Omni 30B, North Mini Code) via OpenRouter em quatro cenários: (1) texto, (2) texto+imagem, (3) áudio, (4) áudio+imagem — todos com coordenadas/horário.

== Modelos e Cenários

Os cenários representam: veículo no acostamento à noite (texto), árvore sobre fiação após tempestade (texto+imagem), gato atropelado (áudio) e residência alagada (áudio+imagem).

#tabela(
  caption: [Cenários testados], 
  columns: (1fr,1fr), 
  width: 50%,
  header: ([Cenário],[Entrada]), 
  [Primeiro],[Texto],
  [Segundo],[Texto e Imagem],
  [Terceiro],[Áudio],
  [Quarto],[Áudio e Imagem]) <tab:cenarios_testados>

== Coleta e Comparações

Registrados `cost`, `response_time_ms`, `prompt_tokens`, `completion_tokens` e erros. Exemplo Nemotron em @tab:exemplo_retorno_nemotron.

#tabela(caption: [Exemplo de métricas por modelo], 
  columns: (2fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr), 
  align: (left, center),
  font-size: 10pt, 
  header: ([Parâmetro],[GPT-5.5],[Claude],[Llama],[Qwen],[Gemini],[Nemotron],[North]), 
  [cost],[0.107],[0.114],[0.006],[0.011],[0.012],[0.005],[0.005],
  [response_time_ms],[44059],[11028],[2634],[47734],[10398],[3910],[6445],
  [prompt_tokens],[15370],[19821],[3658],[3837],[524],[3982],[3655],
  [completion_tokens],[972],[227],[48],[2496],[1336],[351],[497]) <tab:exemplo_retorno_nemotron>

Comparação isolada (uma requisição por modelo, sem transcrição auxiliar):

#tabela(caption: [Comparação por critérios — modelo isolado], 
columns: (2fr,1fr,1fr,1fr,1fr,1fr,1fr,1fr), 
  align: (left, center),
  font-size: 10pt, 
header: ([Critério],[GPT],[Claude],[Llama],[Qwen],[Gemini],[Nemotron],[North]), 
[Texto],[Sucesso],[Sucesso],[Sucesso],[Sucesso],[Sucesso],[Sucesso],[Sucesso],
[Texto+Imagem],[Sucesso],[Falha],[Sucesso],[Sucesso],[Sucesso],[Sucesso],[Falha],
[Áudio],[Falha],[Falha],[Falha],[Falha],[Sucesso],[Falha],[Falha],
[Áudio+Imagem],[Falha],[Falha],[Falha],[Falha],[Sucesso],[Falha],[Falha],
[JSON],[Parcial],[Parcial],[Parcial],[Parcial],[Completo],[Parcial],[Parcial],
[Resposta],[Boa],[Boa],[Boa],[Boa],[Excelente],[Regular],[Boa]) <tab:comparacao_modelos>

Apenas Gemini 3.5 Flash atendeu todos os cenários nativamente. Segunda análise (ecossistema sequencial: áudio→transcrição→classificação) viabilizou GPT e Llama para áudio via modelos auxiliares (GPT Audio, Muse Spark), aproximando cobertura de Gemini; Claude/Qwen permaneceram sem áudio, North só texto.

#tabela(caption: [Viabilidade por ecossistema (composição sequencial)], columns: (1fr,1fr,1fr,1fr,1fr,1fr,1fr,1fr), header: ([Critério],[GPT],[Claude],[Llama],[Qwen],[Gemini],[Nemotron],[North]), [Texto],[Sucesso],[Sucesso],[Sucesso],[Sucesso],[Sucesso],[Sucesso],[Sucesso],[Texto+Imagem],[Sucesso],[Sucesso],[Sucesso],[Sucesso],[Sucesso],[Sucesso],[Falha],[Áudio],[Sucesso],[Falha],[Sucesso],[Falha],[Sucesso],[Sucesso \*],[Falha],[Áudio+Imagem],[Sucesso],[Falha],[Sucesso],[Falha],[Sucesso],[Sucesso \*],[Falha]) <tab:comparacao_ecossistemas>

Análises individuais detalhadas (recomendação, adequação, erros 404/400) confirmam diferenças de endpoints efetivamente disponíveis vs. capacidades anunciadas em interfaces de chat — ponto central do benchmark.

= Conclusão

O Centro de Ajuda demonstrou viabilidade técnica como apoio ao direcionamento emergencial, integrando entrada multimodal, geocodificação, prompts e OpenRouter para entregar `service_name`/`phone_number`/`emergency_context` com redirecionamento `tel:`.

== Avaliação dos Modelos

Apenas Gemini processou nativamente os quatro cenários; demais exigem composição ou ficam restritos a texto/imagem. A disponibilidade depende dos endpoints efetivamente expostos, não só do marketing da família.

== Propostas Futuras

Aperfeiçoamento da aplicação (segurança, acessibilidade, offline com cache validado), ampliação de cenários (ruído, sotaques, baixa luz), avaliação de modelos locais (Llama/Gemma/Qwen) e validação com profissionais das áreas para curadoria de base de contatos por localização.

== Considerações Finais

A prova de conceito integra interface, servidor, localização e LLMs, atendendo ao objetivo, mas não substitui centrais oficiais — é recurso intermediário para reduzir dúvidas e facilitar o acesso ao serviço adequado, com amplo campo de evolução.

#references()

#glossario()

#apendice
= Códigos Complementares
Conteúdo adicional de implementação.

#anexo
= Portaria de Autorização
Conteúdo do anexo A.
