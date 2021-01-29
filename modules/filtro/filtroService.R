#==================================================================
# filtro Service
#
# @input objeto do tipo reactive com os inputs do usuario
# @output objeto do tipo reactive com os outputs do usuario
# @session dados relacionacdos a sessao
# @conexao conexao com banco de dados
#==================================================================
filtroServer = function(input, output, session) {
  #Atualizando estados
  observe({
    estados = filtro.provider.obterEstados(conexao)
    updateSelectInput(
      session = session,
      inputId = "estadoInput",
      choices = estados$name,
      selected = estados$name[1]
    )
  })
  
  #Atualizando municipios
  observe({
    if (input$estadoInput != "") {
      cidades = filtro.provider.obterCidades(input$estadoInput, conexao)
      updateSelectInput(
        session = session,
        inputId = "cidadeInput",
        choices = cidades$municipio,
        selected = cidades$municipio[1]
      )
    }
  })
  
  #Atualizado estacoes
  observe({
    if (input$cidadeInput != "") {
      estacoes = filtro.provider.obterEstacao(input$cidadeInput, conexao)
      updateSelectInput(
        session = session,
        inputId = "stationInput",
        choices = estacoes$code,
        selected = estacoes$code[1]
      )
    }
  })
  
}