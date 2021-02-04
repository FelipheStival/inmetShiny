#==================================================================
# Metodo para obter dados para o sumario
#
# @estado string com estado selecionado
# @return data.frame com dados filtrados
#==================================================================
analise.provider.sumario = function(estado) {
  # obtendo dados
  statement = sprintf(
    "SELECT inmet_daily_data.id,
	   station.id as id_estacao,
	   station.code,
	   city.latitude,
	   city.longitude,
	   state.name as estado,
	   city.name as cidade,
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
	iNNER JOIN station ON inmet_daily_data.station_id = station.id
	INNER JOIN city ON station.city_id = city.id
	INNER JOIN state ON city.state_id = state.id
	WHERE state.name = '%s'
	ORDER BY id_estacao,inmet_daily_data.measurement_date",
    estado
  )
  dados = banco.provider.executeQuery(statement)
  
  # Preparando colunas
  dados = analise.provider.prepare(dados)
  
  # Contar dados perdidos
  dados = analise.provider.contarNA(dados)
  
  # Contar quantidade de anos
  dados = analise.provider.contarANOS(dados)
  
  # Selecionando dados
  dados = dados[, c(
    "code",
    "latitude",
    "longitude",
    "estado",
    "cidade",
    "data_inicio",
    "data_fim",
    "quantidade_anos_temperatura_minima",
    "quantidade_anos_temperatura_maxima",
    "quantidade_anos_precipitacao_minima",
    "quantidade_anos_precipitacao_maxima",
    "quantidade_anos_umidade_relativa_minima_do_ar",
    "quantidade_anos_umidade_relativa_maxima_do_ar",
    "quantidade_anos_velocidade_do_vento" ,
    "quantidade_anos_direcao_do_vento" ,
    "quantidade_anos_radiacao_global" ,
    "quantidade_anos_ponto_de_orvalho_minimo" ,
    "quantidade_anos_ponto_de_orvalho_maximo" ,
    "quantidade_anos_chuva" ,
    "dados_faltantes_temperatura_minima",
    "dados_faltantes_temperatura_maxima" ,
    "dados_faltantes_precipitacao_minima" ,
    "dados_faltantes_precipitacao_maxima" ,
    "dados_faltantes_umidade_relativa_minima_do_ar",
    "dados_faltantes_umidade_relativa_maxima_do_ar",
    "dados_faltantes_velocidade_do_vento" ,
    "dados_faltantes_direcao_do_vento"  ,
    "dados_faltantes_radiacao_global" ,
    "dados_faltantes_ponto_de_orvalho_minimo" ,
    "dados_faltantes_ponto_de_orvalho_maximo" ,
    "dados_faltantes_chuva"
  )]
  
  # Obtendo unicos
  dados = unique(dados)
  
  # Renomeando coluna
  names(dados) = c(
    "Codigo estacao",
    "Latitude",
    "Longitude",
    "Estado",
    "Cidade",
    "Data inicio",
    "Data fim",
    "Quantidade de anos temperatura minima",
    "Quantidade de anos temperatura maxima",
    "Quantidade de anos precipitacao minima",
    "Quantidade de anos precipitacao maxima",
    "Quantidade de anos umidade relativa maxima do ar",
    "Quantidade de anos umidade relativa minima do ar",
    "Quantidade de anos velocidade do vento",
    "Quantidade de anos direcao do vento",
    "Quantidade de anos radiacao global",
    "Quantidade de anos ponto de orvalho minimo",
    "Quantidade de anos ponto de orvalho maximo",
    "Quantidade de anos chuva",
    "Dados faltantes temperatura minima",
    "Dados faltantes temperatura maxima" ,
    "Dados faltantes precipitacao minima" ,
    "Dados faltantes precipitacao maxima" ,
    "Dados faltantes umidade relativa_minima do ar",
    "Dados faltantes umidade relativa maxima do ar",
    "Dados faltantes velocidade do vento" ,
    "Dados faltantes direcao do vento"  ,
    "Dados faltantes radiacao global" ,
    "Dados faltantes ponto de orvalho minimo" ,
    "Dados faltantes ponto de orvalho maximo" ,
    "Dados faltantes chuva"
    
  )
  
  # Removendo nomes linhas
  rownames(dados) = NULL
  
  return(dados)
}


#==================================================================
# Metodo para criar as colunas no data.frame
#
# @dados data.frame a ser preparado
# @return data.frame com colunas criadas
#==================================================================
analise.provider.prepare = function(dados) {
  #Criando colunas quantidade anos
  dados$quantidade_anos_temperatura_minima = 0
  dados$quantidade_anos_temperatura_maxima = 0
  dados$quantidade_anos_precipitacao_minima = 0
  dados$quantidade_anos_precipitacao_maxima = 0
  dados$quantidade_anos_umidade_relativa_minima_do_ar = 0
  dados$quantidade_anos_umidade_relativa_maxima_do_ar = 0
  dados$quantidade_anos_velocidade_do_vento = 0
  dados$quantidade_anos_direcao_do_vento = 0
  dados$quantidade_anos_radiacao_global = 0
  dados$quantidade_anos_ponto_de_orvalho_minimo = 0
  dados$quantidade_anos_ponto_de_orvalho_maximo = 0
  dados$quantidade_anos_chuva = 0
  #Criando colunas contar dados perdidos
  dados$dados_faltantes_temperatura_minima = 0
  dados$dados_faltantes_temperatura_maxima = 0
  dados$dados_faltantes_precipitacao_minima = 0
  dados$dados_faltantes_precipitacao_maxima = 0
  dados$dados_faltantes_umidade_relativa_minima_do_ar = 0
  dados$dados_faltantes_umidade_relativa_maxima_do_ar = 0
  dados$dados_faltantes_velocidade_do_vento = 0
  dados$dados_faltantes_direcao_do_vento = 0
  dados$dados_faltantes_radiacao_global = 0
  dados$dados_faltantes_ponto_de_orvalho_minimo = 0
  dados$dados_faltantes_ponto_de_orvalho_maximo = 0
  dados$dados_faltantes_chuva = 0
  #Criando coluna data inicio e data fim
  dados$data_inicio = min(dados$measurement_date)
  dados$data_fim = max(dados$measurement_date)
  return(dados)
}

#==================================================================
# Metodo para contar a quantidade de dados perdidos por coluna
#
# @dados data.frame a ser preparado
# @return data.frame com colunas criadas
#==================================================================
analise.provider.contarNA = function(dados) {
  estacoes = unique(dados$code)
  for (estacao in estacoes) {
    tempData = dados[dados$code %in% estacao,]
    quantidade = colSums(tempData == 0)
    
    #Preechendo valores
    dados[dados$code %in% estacao, "dados_faltantes_temperatura_minima"] = quantidade[9]
    dados[dados$code %in% estacao, "dados_faltantes_temperatura_maxima"] = quantidade[10]
    dados[dados$code %in% estacao, "dados_faltantes_precipitacao_minima"] = quantidade[11]
    dados[dados$code %in% estacao, "dados_faltantes_precipitacao_maxima"] = quantidade[12]
    dados[dados$code %in% estacao, "dados_faltantes_umidade_relativa_minima_do_ar"] = quantidade[13]
    dados[dados$code %in% estacao, "dados_faltantes_umidade_relativa_maxima_do_ar"] = quantidade[14]
    dados[dados$code %in% estacao, "dados_faltantes_velocidade_do_vento"] = quantidade[15]
    dados[dados$code %in% estacao, "dados_faltantes_direcao_do_vento"] = quantidade[16]
    dados[dados$code %in% estacao, "dados_faltantes_radiacao_global"] = quantidade[17]
    dados[dados$code %in% estacao, "dados_faltantes_ponto_de_orvalho_minimo"] = quantidade[18]
    dados[dados$code %in% estacao, "dados_faltantes_ponto_de_orvalho_maximo"] = quantidade[20]
    dados[dados$code %in% estacao, "dados_faltantes_chuva"] = quantidade[20]
  }
  
  return(dados)
}

#==================================================================
# Metodo para contar a quantidade de anos completos por cada estacao
#
# @dados data.frame a ser preparado
# @return data.frame com colunas criadas
#==================================================================
analise.provider.contarANOS = function(dados) {
  # Criando coluna ano
  dados$ano = format(dados$measurement_date, "%Y")
  
  # Obtendo nomes estacoes
  nomesColunas = names(dados)[9:20]
  nomesAcumular = names(dados)[21:32]
  
  # Obtendo estacao
  estacoes = unique(dados$code)
  
  for (estacao in estacoes) {
    anos = unique(dados[dados$code %in% estacao, "ano"])
    for (ano in anos) {
      tempData = dados[dados$code %in% estacao &
                         dados$ano %in% ano,]
      for (i in 1:length(nomesColunas)) {
        checarAno = which(tempData[, nomesColunas[i]] == 0)
        if (length(checarAno) == 0) {
          dados[dados$code %in% estacao, nomesAcumular[i]] =  dados[dados$code %in% estacao, nomesAcumular[i]] + 1
        }
      }
    }
  }
  
  return(dados)
}