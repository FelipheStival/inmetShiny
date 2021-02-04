#==================================================================
# Analise Service
#
# @input objeto do tipo reactive com os inputs do usuario
# @output objeto do tipo reactive com os outputs do usuario
# @session dados relacionacdos a sessao
# @conexao conexao com banco de dados
#==================================================================
analiseServer = function(input, output, session) {
  
  # Dados analise
  dadosAnalise = reactive({
    analise.provider.sumario(input$estadoInput)
  })
  
  # Tabela analise
  output$tabelaSumario = renderDataTable({
    dadosAnalise()
  }, class = "cell-border",
  options = list(
    lengthMenu = c(5, 10, 15, 20),
    pageLength = 10,
    scrollX = TRUE
  ),
  rownames = FALSE)
  
  # Download sumario
  output$DownloadSumario = downloadHandler(
    filename = function() {
      paste("Sumario-", input$estadoInput, ".csv", sep = "")
    },
    content = function(file) {
      write.csv(dadosAnalise(), file, row.names = FALSE)
    }
  )
}