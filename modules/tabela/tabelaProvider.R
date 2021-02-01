#==================================================================
# Metodo para obter dados para a tabela
#
# @param conexao conexao com banco de dados
# @return data.frame com dados dos estados
#==================================================================
tabela.provider.dados = function(municipio, startDate, endDate) {
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
	   inmet_daily_data.global_radiation, minimum_dew_point,
	   inmet_daily_data.maximum_dew_point,
	   inmet_daily_data.rain
	FROM public.inmet_daily_data
	INNER JOIN station ON inmet_daily_data.station_id = station.id
	INNER JOIN city ON station.city_id = city.id
	WHERE city.name = '%s'
	AND
	inmet_daily_data.measurement_date >= '%s'
	AND
	inmet_daily_data.measurement_date <= '%s'
	ORDER BY inmet_daily_data.measurement_date
	",
    municipio,
    startDate,
    endDate
  )
  dados = banco.provider.executeQuery(statement)
  return(dados)
}

#==================================================================
# Metodo para obter dados horarios
#
# @param conexao conexao com banco de dados
# @return data.frame com dados dos estados
#==================================================================
tabela.provider.dados.horarios = function(municipio, startDate, endDate) {
  statement = sprintf(
    "SELECT inmet_hourly_data.id,
       inmet_hourly_data.station_id,
	   inmet_hourly_data.measurement_date,
	   inmet_hourly_data.measure_time,
	   inmet_hourly_data.minimum_temperature,
	   inmet_hourly_data.maximum_temperature,
	   inmet_hourly_data.instant_temperature,
	   inmet_hourly_data.minimum_precipitation,
	   inmet_hourly_data.maximum_precipitation,
	   inmet_hourly_data.instant_precipitation,
	   inmet_hourly_data.minimum_relative_air_humidity,
	   inmet_hourly_data.maximum_relative_air_humidity,
	   inmet_hourly_data.instant_relative_air_humidity,
	   inmet_hourly_data.wind_speed,
	   inmet_hourly_data.wind_direction,
	   inmet_hourly_data.blast,
	   inmet_hourly_data.global_radiation,
	   inmet_hourly_data.minimum_dew_point,
	   inmet_hourly_data.maximum_dew_point,
	   inmet_hourly_data.instant_dew_point,
	   inmet_hourly_data.rain
	FROM public.inmet_hourly_data
	INNER JOIN station ON inmet_hourly_data.station_id = station.id
	INNER JOIN city ON station.city_id = city.id
	WHERE city.name = '%s'
	AND
	inmet_hourly_data.measurement_date >= '%s'
	AND
	inmet_hourly_data.measurement_date <= '%s'
	ORDER BY inmet_hourly_data.measurement_date,inmet_hourly_data.measure_time",
    municipio,
    startDate,
    endDate
  )
  dados = banco.provider.executeQuery(statement)
  return(dados)
}