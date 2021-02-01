#==================================================================
# Metodo para obter dados para os graficos
#
# @param conexao conexao com banco de dados
# @return data.frame com dados dos estados
#==================================================================
graficos.provider.dados = function(municipio,startDate,endDate) {
  statement = sprintf("SELECT inmet_daily_data.id,
       inmet_daily_data.station_id,
	   inmet_daily_data.measurement_date,
	   inmet_daily_data.minimum_temperature,
	   inmet_daily_data.maximum_temperature,
	   inmet_daily_data.minimum_precipitation,
	   inmet_daily_data.maximum_precipitation,
	   inmet_daily_data.minimum_relative_air_humidity,
	   inmet_daily_data.maximum_relative_air_humidity,
	   inmet_daily_data.wind_speed, wind_direction,
	   inmet_daily_data.global_radiation,
	   inmet_daily_data.minimum_dew_point,
	   inmet_daily_data.maximum_dew_point,
	   inmet_daily_data.rain
	FROM public.inmet_daily_data
	INNER JOIN station ON inmet_daily_data.station_id = station.id
	INNER JOIN city ON station.city_id = city.id
	WHERE city.name = '%s'
	AND
	inmet_daily_data.measurement_date >= '%s'
	AND 
	inmet_daily_data.measurement_date <= '%s'",municipio,startDate,endDate)
  dados = banco.provider.executeQuery(statement)
  colnames(dados)[3] = "data"
  return(dados)
}

#==================================================================
# Metodo para preparar os dados para o grafico de perdidos
#
# @param conexao conexao com banco de dados
# @return data.frame com dados dos estados
#==================================================================
graficos.provider.dadosPerdidos = function(dados) {
  # Nomes colunas
  nomesColunas = colnames(dados)
  
  # Substituindo 0 por NA
  for (nome in nomesColunas) {
    indexNA = which(dados[, nome] == 0)
    if (length(indexNA) > 0) {
      dados[indexNA, nome] = NA
    }
  }
  
  # Selecionando colunas
  dados = dados[, c(
    "minimum_temperature",
    "maximum_temperature",
    "minimum_precipitation",
    "maximum_precipitation",
    "minimum_relative_air_humidity",
    "maximum_relative_air_humidity",
    "wind_speed",
    "wind_direction",
    "global_radiation",
    "minimum_dew_point",
    "maximum_dew_point",
    "rain"
  )]
  return(dados)
}

#======================================================================
# Metodo para obter as cores dos graficos
#
# @param variavelSelected variavel selecionada
# @return objeto do tipo string com a cor do grafico
#======================================================================
graficos.provider.grafico.cor = function(variavelSelect) {
  cor = NULL
  switch (
    variavelSelect,
    "minimum_temperature" = {
      cor = "tomato"
    },
    "maximum_temperature" = {
      cor = "cyan"
    },
    "minimum_precipitation" = {
      cor = "blue"
    },
    "maximum_precipitation" = {
      cor = "blue"
    },
    "minimum_relative_air_humidity" = {
      cor = "DarkCyan"
    },
    "maximum_relative_air_humidity" = {
      cor = "DarkCyan"
    },
    "wind_speed" = {
      cor = "DarkGray"
    },
    "global_radiation" = {
      cor = "orange"
    }
  )
  return(cor)
}