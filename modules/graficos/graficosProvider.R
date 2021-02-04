#==================================================================
# Metodo para obter dados para os graficos
#
# @param conexao conexao com banco de dados
# @return data.frame com dados dos estados
#==================================================================
graficos.provider.dados = function(municipio, startDate, endDate) {
  statement = sprintf(
    "SELECT inmet_daily_data.id,
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
	inmet_daily_data.measurement_date <= '%s'",
    municipio,
    startDate,
    endDate
  )
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
graficos.provider.dadosPerdidos = function(estado, inicio, fim) {
  # Executnado query
  statement = sprintf(
    "SELECT
	   station.code as codigo_estacao,
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
	INNER JOIN state ON city.state_id = state.id
	WHERE state.name = '%s'
	AND
	inmet_daily_data.measurement_date >= '%s'
	AND
	inmet_daily_data.measurement_date <= '%s'",
    estado,
    inicio,
    fim
  )
  dados = banco.provider.executeQuery(statement)
  
  
  # Nomes colunas
  nomesColunas = colnames(dados)
  
  # Substituindo 0 por NA
  for (nome in nomesColunas) {
    indexNA = which(dados[, nome] == 0)
    if (length(indexNA) > 0) {
      dados[indexNA, nome] = NA
    }
  }
  
  # Preparando dados para gerar o grafico
  naTabela = melt(dados, id.vars = "codigo_estacao")
  naTabela = dcast(
    naTabela,
    codigo_estacao ~ variable,
    value.var = "value",
    fun.aggregate = naCounter
  )
  naTabela = melt(naTabela, id.vars = "codigo_estacao")
  names(naTabela) = c("Estacao", "Variavel", "Valor")
  
  
  return(naTabela)
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
      cor = "tomato"
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
    },
    "rain" = {
      cor = "LightSteelBlue"
    }
  )
  return(cor)
}

#======================================================================
# Metodo para obter as legendas para o grafico
#
# @param variavelSelected variavel selecionada
# @return objeto do tipo string com a legenda do grafico
#======================================================================
graficos.provider.grafico.legenda = function(variavelSelect) {
  legenda = NULL
  switch (
    variavelSelect,
    "minimum_temperature" = {
      legenda = "Temperatura minima(*C)"
    },
    "maximum_temperature" = {
      legenda = "Temperatura maxima(*C)"
    },
    "minimum_relative_air_humidity" = {
      legenda = "Umidade minima do ar(%)"
    },
    "maximum_relative_air_humidity" = {
      legenda = "Umidade maxima do ar(%)"
    },
    "wind_speed" = {
      legenda =  "Velocidade do Vento(%)"
    },
    "global_radiation" = {
      legenda = "Radiacao solar global(MJ/m2)"
    },
    "rain" = {
      legenda = "Precipitacao(mm)"
    }
  )
  return(legenda)
}

#======================================================================
# Metodo para obter os anos para atualizar input
#
# @param dados base de dados da estacao
# @return vetor com datas
#======================================================================
graficos.provider.grafico.anos = function(dados) {
  anos = unique(format(dados$data, "%Y"))
  anos = sort(as.numeric(anos))
  return(anos)
}

#======================================================================
# Metodo para contar os NA de um vetor
#
# @param values vetor a ser contado os NA
# @return porcentagem de NA
#======================================================================
naCounter = function(values) {
  index = which(is.na(values))
  rate = length(index) / length(values)
  return(rate * 100)
}
