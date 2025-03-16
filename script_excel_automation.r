library(openxlsx)

tryCatch({
  registro <- readLines("códigos_de_registro.txt")
  
  print(paste("Número de registros lidos:", length(registro)))
  
  df <- data.frame(Códigos = registro)
  
  write.xlsx(df, "códigos_de_registro.xlsx", rowNames = FALSE)
  
  print("Arquivo Excel criado com sucesso!")
  
}, error = function(e) {
  print(paste("Erro:", e$message))
})