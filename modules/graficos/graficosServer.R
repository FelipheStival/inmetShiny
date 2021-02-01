#==================================================================
# Graficos Server
#
# @input objeto do tipo reactive com os inputs do usuario
# @output objeto do tipo reactive com os outputs do usuario
# @session dados relacionacdos a sessao
# @data objeto do tipo data.frame com dados das estacoes
#==================================================================
graficosServer = function(input, output, session) {
  
  # Dados graficos
  dadosGraficos = reactive({
    dados = graficos.provider.dados(input$cidadeInput,
                                    input$periodoInput[1],
                                    input$periodoInput[2]
                                    )
    return(dados)
  })
  
  
  # Grafico dados perdidos
  output$dadosPerdidosPlot = renderPlotly({
    dados = graficos.provider.dadosPerdidos(dadosGraficos())
    graficos.chart.dadosPerdidos(dados)
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
      Coluna = "maximum_precipitation"
    )
  })
  
  #Grafico precipitacao Cumulativa
  output$PrecipitacaoCumulativaPlot = renderPlot({
    grafico.precipitacaoAcumulada(
      dados = dadosGraficos(),
      Municipio = input$cidadeInput,
      Coluna = "maximum_precipitation"
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
}