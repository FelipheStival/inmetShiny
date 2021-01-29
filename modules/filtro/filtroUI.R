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
    selectInput(
      inputId = "stationInput",
      label = "Selecione a estacao:",
      choices = NULL
    )
  )
  
}