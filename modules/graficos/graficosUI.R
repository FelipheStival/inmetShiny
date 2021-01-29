#==================================================================
# Dados perdidos UI
#==================================================================
createdadosPerdidosUI = function() {
  #criando janela
  tabItem(tabName = "dadosPerdidosplot",
          box(width = 12,
              withSpinner(
                plotlyOutput("dadosPerdidosPlot", width = "100%")
              )))
}

#==================================================================
# Mapa Matriz UI
#==================================================================
createMapaMatrizUI = function() {
  #criando janela
  tabItem(tabName = "mapaMatrizplot",
          box(
            width = 4,
            selectInput(
              inputId = "variavelSelect",
              label = "Selecione a variavel:",
              choices = c(
                "Precipitacao minima(mm)" = "minimum_precipitation",
                "Precipitacao maxima(mm)" = "maximum_precipitation",
                "Temperatura maxima(*C)" = "maximum_temperature",
                "Temperatura minima(*C)" = "minimum_temperature",
                "Radiacao solar global(MJ/m2)" = "global_radiation",
                "Umidade minima(%)" = "minimum_relative_air_humidity",
                "Umidade maxima(%)" = "maximum_relative_air_humidity",
                "Velocidade do vento(%)" = "wind_speed"
              )
            ),
            selectInput(
              inputId = "grupoDiasSelect",
              label = "Selecione o grupo de dias:",
              choices = c(
                "10 dias" = 10,
                "21 dias" = 21,
                "Mensal" = "mon"
              )
            )
          ),
          box(
            width = 8,
            plotOutput("Matrizplot", width = "100%", height = "85vh")
          ))
}

#==================================================================
# Precipitacao UI
#==================================================================
createPrecipitacaoUI = function() {
  #criando janela
  tabItem(tabName = "Precipitacaoplot",
          box(
            width = 4,
            selectInput(
              inputId = "grupoDiasSelectPrec",
              label = "Selecione o grupo de dias:",
              choices = c(
                "10 dias" = 10,
                "21 dias" = 21,
                "Mensal" = "mon"
              )
            )
          ),
          box(
            width = 8,
            plotOutput("plotPrecipitacao", width = "100%", height = "85vh")
          ))
}

#==================================================================
# Precipitacao acumulada UI
#==================================================================
createPrecipitacaoCumulativaUI = function() {
  #criando janela
  tabItem(tabName = "PrecipitacaoCumulativa",
          box(width = 12,
              plotOutput("PrecipitacaoCumulativaPlot")))
}

#==================================================================
# Periodo chuvoso UI
#==================================================================
createPeriodoChuvosoUI = function() {
  #criando janela
  tabItem(tabName = "periodoChuvosoPlot",
          box(width = 12,
              plotOutput("periodoChuvosoPlot")))
}



#==================================================================
# Graficos menu item
#==================================================================
itemMenuGraficos = function() {
  menuItem(
    text = "Graficos",
    tabName = "analiseUI",
    icon = icon("line-chart"),
    menuSubItem(
      text = "Dados peridos",
      tabName = "dadosPerdidosplot",
      icon = icon("bar-chart")
    ),
    menuSubItem(
      text = "Mapa matriz",
      tabName = "mapaMatrizplot",
      icon = icon("bar-chart")
    ),
    menuSubItem(
      text = "Precipitacao",
      tabName = "Precipitacaoplot",
      icon = icon("bar-chart")
    ),
    menuSubItem(
      text = "Precipitacao cumulativa",
      tabName = "PrecipitacaoCumulativa",
      icon = icon("bar-chart")
    ),
    menuSubItem(
      text = "Periodo Chuvoso",
      tabName = "periodoChuvosoPlot",
      icon = icon("bar-chart")
    )
  )
  
}