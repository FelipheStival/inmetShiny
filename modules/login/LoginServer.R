#==================================================================
# Login Server
#
# @input objeto do tipo reactive com os inputs do usuario
# @output objeto do tipo reactive com os outputs do usuario
# @session dados relacionacdos a sessao
# @data objeto do tipo data.frame com dados das estacoes
#==================================================================
loginServer = function(input,output,session){
  
  # Credenciais
  credentials <- data.frame(
    user = c("embrapa"), # mandatory
    password = c("embrapa"), # mandatory
    stringsAsFactors = FALSE
  )
  
  # Configurando labels
  set_labels(
    language = "en",
    "Please authenticate" = "Login",
    "Username:" = "Usuario:",
    "Password:" = "Senha:",
    "Username or password are incorrect" = "Nome de usuario ou senha incorretos"
  )
  
  # Checagem Login
  res_auth <- secure_server(
    check_credentials = check_credentials(credentials)
  )
  
}