#==================================================================
# Metodo para gerar o grafico de dados perdidos
#
# @param conexao conexao com banco de dados
# @return data.frame com dados dos estados
#==================================================================
graficos.chart.dadosPerdidos = function(dados) {
  grafico = heatmaply_na(dados)
  return(grafico)
}

#==================================================================
# Metodo para criar o grafico matriz
#
# @param conexao conexao com banco de dados
# @return data.frame com dados dos estados
#==================================================================
graficos.GraficoMatriz = function(dados, Municipio, Coluna, cor, intervalo)
{
  intervalo = ifelse(!is.na(as.numeric(intervalo)), as.numeric(intervalo), "mon")
  dados[[Coluna]] = as.numeric(dados[[Coluna]])
  
  dados$data = as.Date(dados$data)
  year.max = format(max(dados$data), "%Y")
  year.min = format(min(dados$data), "%Y")
  
  titulo = sprintf("Municipio '%s'\n %s - %s", Municipio, year.min, year.max)
  
  indexData = which(names(dados) == "data")
  names(dados)[indexData] = "date"
  
  dados = dados[, c("date", Coluna)]
  
  paleta = colorRampPalette(c("white", cor))(64)
  
  dados.sum = seas.sum(dados,
                       start = 1,
                       var = Coluna,
                       width = intervalo)
  image(
    dados.sum,
    Coluna,
    palette = paleta,
    main = titulo,
    ylab = "Precipitacao pluvial (mm)"
  )
  
}

#==================================================================
# Metodo para criar o grafico de precipitacao
#
# @param conexao conexao com banco de dados
# @return data.frame com dados dos estados
#==================================================================
grafico.precipitacao = function(dados, Municipio, Grupodias, Coluna)
{
  Grupodias = ifelse(!is.na(as.numeric(Grupodias)), as.numeric(Grupodias), "mon")
  dados[[Coluna]] = as.numeric(dados[[Coluna]])
  
  dados$data = as.Date(dados$data)
  year.max = format(max(dados$data), "%Y")
  year.min = format(min(dados$data), "%Y")
  
  titulo = sprintf("Municipio '%s'\n %s - %s", Municipio, year.min, year.max)
  
  indexData = which(names(dados) %in% c("data", Coluna))
  names(dados)[indexData] = c("date", "precip")
  
  dados$rain = dados$precip
  dados$id = NULL
  dados$snow = 0
  
  
  s.s = seas.sum(dados, width = Grupodias)
  s.n = seas.norm(s.s, fun = "mean")
  
  
  plot(s.n,
       start = 1,
       main = titulo,
       ylab = "Precipitacao pluvial (mm/dia)")
  
}

#======================================================================
# Metodo para criar o grafico basico
#
# @param dados data.frame com dados do grafico
# @param Municipio municipio selecionado
# @param Coluna coluna selecionada
#======================================================================
grafico.precipitacaoAcumulada = function(dados, Municipio, Coluna)
{
  dados[[Coluna]] = as.numeric(dados[[Coluna]])
  
  dados$data = as.Date(dados$data)
  year.max = format(max(dados$data), "%Y")
  year.min = format(min(dados$data), "%Y")
  
  titulo = sprintf("Municipio '%s'\n %s - %s", Municipio, year.min, year.max)
  
  indexData = which(names(dados) %in% c("data", Coluna))
  names(dados)[indexData] = c("date", "precip")
  
  dados$rain = dados$precip
  dados$id = NULL
  dados$snow = 0
  
  
  s.s = seas.sum(dados, width = 10)
  s.n = precip.norm(s.s, fun = "mean")
  
  dat.dep = precip.dep(dados, s.n)
  
  plot(dep ~ date,
       dat.dep,
       type = "l",
       main = titulo,
       ylab = "Precipitacao pluvial cumulativa (mm/dia)")
  
}

#======================================================================
# Metodo para criar o grafico do periodo climatico
#
# @param dados data.frame com dados do grafico
# @param Municipio municipio selecionado
# @param Coluna coluna selecionada
#======================================================================
graficos.periodoClimatico = function(dados, Municipio, Coluna) {
  dados$data = as.Date(dados$data)
  dados[[Coluna]] = as.numeric(dados[[Coluna]])
  
  R.prec = mean(dados[[Coluna]])
  dados$R_diff = NA
  
  for (linha in 1:dim(dados)[1]) {
    if (linha == 1) {
      dados$R_diff[linha] = dados[[Coluna]][linha] - R.prec
    } else{
      dados$R_diff[linha] = (dados[[Coluna]][linha] - R.prec) + dados$R_diff[linha -
                                                                               1]
    }
  }
  
  dados$ano = format(dados$data, "%Y")
  dados$mes = format(dados$data, "%m")
  
  resumo = dcast(dados, ano ~ mes, value.var = "R_diff", fun = mean)
  
  prec_media = apply(resumo[,-1], 2, mean)
  prec_media = data.frame(mes = names(prec_media), media = prec_media)
  
  inicioChuva = prec_media$mes[prec_media$media == min(prec_media$media)]
  fimChuva = prec_media$mes[prec_media$media == max(prec_media$media)]
  
  inicioChuva = as.numeric(as.character(inicioChuva))
  fimChuva = as.numeric(as.character(fimChuva))
  
  resumo = melt(
    resumo,
    id.vars = "ano",
    variable.name = "mes",
    value.name = "R_diff"
  )
  resumo$status = resumo$mes %in% c(inicioChuva, fimChuva)
  resumo$mes = as.numeric(as.character(resumo$mes))
  
  resumo$periodo = !(resumo$mes %in% fimChuva:inicioChuva)
  resumo$periodo[resumo$mes == fimChuva] = "Inicio / Final das chuvas"
  resumo$periodo[resumo$mes == inicioChuva] = "Inicio / Final das chuvas"
  
  breaks = c("TRUE", "FALSE", "Inicio / Final das chuvas")
  labels = c("Periodo chuvoso", "Periodo seco", "Inicio / Final das chuvas")
  titulo = sprintf("Periodos climaticos da estacao %s", Municipio)
  col = c("#ff9999", "gray", "#56B4E9")
  
  ggplot(resumo, aes(factor(mes), R_diff)) + geom_boxplot(aes(fill = periodo)) +
    scale_fill_manual(breaks = breaks,
                      labels = labels,
                      values = col) +
    labs(title = titulo, x = "Mes", y = "Anomalia da precipitacao pluvial media acumulada por dia (mm)") + theme_bw() +
    scale_x_discrete(
      labels = c(
        "Janeiro",
        "Feveiro",
        "Marco",
        "Abril",
        "Maio",
        "Junho",
        "Julho",
        "Agosto",
        "Setembro",
        "Outobro",
        "Novembro",
        'Dezembro'
      )
    )
}
