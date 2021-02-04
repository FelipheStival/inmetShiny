#==================================================================
# Graficos Server
#
# @input objeto do tipo reactive com os inputs do usuario
# @output objeto do tipo reactive com os outputs do usuario
# @session dados relacionacdos a sessao
# @data objeto do tipo data.frame com dados das estacoes
#==================================================================
graficosServer = function(input, output, session) {
  # Dados graficos basicos
  dadosGraficos = reactive({
    dados = graficos.provider.dados(input$cidadeInput,
                                    input$periodoInput[1],
                                    input$periodoInput[2])
    return(dados)
  })
  
  # Dados grafico heatmap
  dadosHeatMap = reactive({
    dados = graficos.provider.dadosPerdidos(input$estadoInput,
                                            input$periodoInput[1],
                                            input$periodoInput[2])
  })
  
  # Grafico dados perdidos
  output$dadosPerdidosPlot = renderPlot({
    graficos.chart.dadosPerdidos(dadosHeatMap())
  })
  
  # Grafico matriz
  output$Matrizplot = renderPlot({
    graficos.GraficoMatriz(
      dados = dadosGraficos(),
      Municipio = input$cidadeInput,
      Coluna = input$variavelSelect,
      cor = graficos.provider.grafico.cor(input$variavelSelect),
      intervalo = input$grupoDiasSelect
    )
  })
  
  #Grafico precipitacao
  output$plotPrecipitacao = renderPlot({
    grafico.precipitacao(
      dados = dadosGraficos(),
      Municipio = input$cidadeInput,
      Grupodias = input$grupoDiasSelectPrec,
      Coluna = "rain"
    )
  })
  
  #Grafico precipitacao Cumulativa
  output$PrecipitacaoCumulativaPlot = renderPlot({
    grafico.precipitacaoAcumulada(
      tabela = dadosGraficos(),
      Municipio = input$cidadeInput,
      Coluna = "rain"
    )
  })
  
  #Grafico precipitacao climativo
  output$periodoChuvosoPlot = renderPlot({
    graficos.periodoClimatico(
      dados = dadosGraficos(),
      Municipio = input$cidadeInput,
      Coluna = "maximum_precipitation"
    )
  })
  
  # Grafico boxplot
  output$graficosPerdidosPlot = renderPlot({
    grafico.boxplot(
      tabela = dadosGraficos(),
      nomeEstacao = input$cidadeInput,
      Grupodias = input$grupodiasBoxPlot,
      colunaVariavel = input$boxplotVariavel,
      color = graficos.provider.grafico.cor(input$boxplotVariavel),
      ylab = graficos.provider.grafico.legenda(input$boxplotVariavel)
    )
  })
  
  # Grafico Seco Umido
  output$secoUmidoPlot = renderPlot({
    grafico.diaSecoUmido(
      tabela = dadosGraficos(),
      colunaPrecipitacao = "rain",
      Municipio = input$cidadeInput,
      intervalo = input$secoUmidoGrupoDias
    )
  })
}