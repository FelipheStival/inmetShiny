#==================================================================
# Dados perdidos UI
#==================================================================
createdadosPerdidosUI = function() {
  #criando janela
  tabItem(tabName = "dadosPerdidosplot",
          box(width = 12,
              withSpinner(
                plotOutput("dadosPerdidosPlot", width = "100%", height = "85vh")
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
                "Precipitacao" = "rain",
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
# grafico dia seco e umido
#==================================================================
createDiaSecoUmidoUI = function() {
  #criando janela
  tabItem(tabName = "diaSecoUmido",
          box(
            width = 4,
            selectInput(
              inputId = "secoUmidoGrupoDias",
              label = "Selecione o grupo de dias:",
              choices = c(
                "10 dias" = 10,
                "21 dias" = 21,
                "Mensal" = "mon"
              )
            )
          ),
          box(width = 8,
              plotOutput("secoUmidoPlot")))
}


#==================================================================
# grafico Boxplot chuvoso UI
#==================================================================
createGraficoBasicoUI = function() {
  #criando janela
  tabItem(tabName = "graficosPerdidosPlot",
          box(
            width = 4,
            selectInput(
              inputId = "boxplotVariavel",
              label = "Selecione a variavel:",
              choices = c(
                "Temperatura minima(*C)" = "minimum_temperature",
                "Temperatura maxima(*C)" = "maximum_temperature",
                "Umidade minima do ar(%)" = "minimum_relative_air_humidity",
                "Umidade maxima do ar(%)" = "maximum_relative_air_humidity",
                "Velocidade do Vento(%)" = "wind_speed",
                "Radiacao solar global(MJ/m2)" = "global_radiation",
                "Precipitacao(mm)" = "rain"
              )
            ),
            selectInput(
              inputId = "grupodiasBoxPlot",
              label = "Selecione o grupo de dias:",
              choices = c(
                "10 Dias" = 10,
                "21 Dias" = 21,
                "Mensal" = "Mon"
              )
            )
          ),
          box(
            width = 8,
            plotOutput(
              "graficosPerdidosPlot",
              width = "100%",
              height = "80vh"
            )
          ))
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
      text = "Dados perdidos",
      tabName = "dadosPerdidosplot",
      icon = icon("bar-chart")
    ),
    menuSubItem(
      text = "Grafico basico",
      tabName = "graficosPerdidosPlot",
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
      text = "Dia seco e umido",
      tabName = "diaSecoUmido",
      icon = icon("bar-chart")
    ),
    menuSubItem(
      text = "Periodo Chuvoso",
      tabName = "periodoChuvosoPlot",
      icon = icon("bar-chart")
    )
  )
  
}