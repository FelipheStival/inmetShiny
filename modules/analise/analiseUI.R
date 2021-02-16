#==================================================================
# Tabela UI
#==================================================================
createAnaliseUI = function() {
  #criando janela
  tabItem(tabName = "analiseUI",
          tabBox(width = "100%",
                 tabPanel(
                   "Analise",
                   withSpinner(dataTableOutput("tabelaSumario")),
                   downloadButton("DownloadSumario", label = "Download")
                         )
                 )
          )
}

#==================================================================
# Tabela menu item
#==================================================================
itemMenuAnalise = function() {
  menuItem(text = "Analise",
           tabName = "analiseUI",
           icon = icon("search"))
  
}