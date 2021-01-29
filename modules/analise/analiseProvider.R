#==================================================================
# Metodo para obter dados para o sumario
#
# @estado string com estado selecionado
# @return data.frame com dados filtrados
#==================================================================
analise.provider.sumario = function(estado) {
  statement = sprintf(
    "SELECT    station.id,
		  station.code as id_estacao,
		  city.latitude,
		  city.longitude,
		  city.name as municipio
	FROM station
	INNER JOIN city ON station.city_id = city.id
	INNER JOIN state ON city.state_id = state.id
	WHERE state.name = '%s'",
    estado
  )
  dados = banco.provider.executeQuery(statement)
  return(dados)
}
