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
      choices = "GO"
    ),
    selectInput(
      inputId = "cidadeInput",
      label = "Selecione a cidade: ",
      choices = NULL
    ),
    dateRangeInput(
      inputId = "periodoInput",
      label = "Selecione o periodo:",
      start = '2021-02-11',
      end = '2021-02-15'
    )
  )
  
}