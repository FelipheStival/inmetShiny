#==================================================================
# Tabela UI
#==================================================================
createAnaliseUI = function() {
  #criando janela
  tabItem(tabName = "analiseUI",
          box(width = 12,
              dataTableOutput("tabelaSumario")))
}

#==================================================================
# Tabela menu item
#==================================================================
itemMenuAnalise = function() {
  menuItem(text = "Analise",
           tabName = "analiseUI",
           icon = icon("search"))
  
}