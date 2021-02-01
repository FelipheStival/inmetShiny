#==================================================================
# Filtro UI
#==================================================================
itemFiltroUI = function() {
  menuItem(
    text = "Selecione a estacao",
    icon = icon("street-view"),
    selectInput(
      inputId = "estadoInput",
      label = "Selecione o estado:",
      choices = NULL
    ),
    selectInput(
      inputId = "cidadeInput",
      label = "Selecione a cidade: ",
      choices = NULL
    ),
    dateRangeInput(
      inputId = "periodoInput",
      label = "Selecione o periodo:",
      start = Sys.Date(),
      end = Sys.Date()
    )
  )
  
}