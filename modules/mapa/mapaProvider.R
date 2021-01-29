#==================================================================
# Metodo para obter dados para desenhar o mapa
#
# @estado string com estado selecionado
# @return data.frame com dados filtrados
#==================================================================
mapa.provider.dadosMapa = function(estado){
  statement = sprintf("SELECT    station.id, 
		  station.code as id_estacao,
		  city.latitude,
		  city.longitude,
		  city.name as municipio
	FROM station 
	INNER JOIN city ON station.city_id = city.id
	INNER JOIN state ON city.state_id = state.id
	WHERE state.name = '%s'",estado)
  dados = banco.provider.executeQuery(statement)
  return(dados)
}
