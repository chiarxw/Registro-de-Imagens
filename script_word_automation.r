library(officer)

caminho_pasta <- "D:/textosraw"

arquivos_txt <- list.files(path = caminho_pasta, pattern = "\\.txt$", full.names = TRUE)

if (length(arquivos_txt) == 0) {
  stop("Nenhum arquivo .txt encontrado na pasta especificada!")
}

doc <- read_docx()

ajustar_codificacao <- function(arquivo) {
  conteudo <- readLines(arquivo, warn = FALSE, encoding = "UTF-8")
  conteudo <- iconv(conteudo, from = "ISO-8859-1", to = "UTF-8", sub = "byte")
  return(conteudo)
}

limpar_caracteres <- function(texto) {
  texto <- gsub("[^[:print:]\n]", "", texto)
  return(texto)
}

adicionar_paragrafos <- function(doc, texto) {
  paragrafos <- unlist(strsplit(texto, "\n"))
  
  for (paragrafo in paragrafos) {
    doc <- body_add_par(doc, value = paragrafo, style = "Normal")
  }
  return(doc)
}

cat("Iniciando a execução do script...\n")

for (arquivo in arquivos_txt) {
  cat(sprintf("Processando o arquivo: %s\n", arquivo))
  
  conteudo <- ajustar_codificacao(arquivo)
  conteudo <- limpar_caracteres(conteudo)
  conteudo <- gsub("<[^>]+>", "", conteudo) 
  conteudo <- gsub("[<>|]", "", conteudo)   
  
  texto <- paste(conteudo, collapse = "\n")
  
  doc <- body_add_par(doc, value = paste("Arquivo:", basename(arquivo)), style = "heading 2")
  doc <- adicionar_paragrafos(doc, texto)
  doc <- body_add_par(doc, value = "\n")
}

cat("Finalizando o documento...\n")

output_file <- "arquivos_combinados_com_formatacao.docx"

cat("Verificando o conteúdo do documento...\n")
print(doc) 

print(doc, target = output_file)
cat("Documento salvo com sucesso em:", output_file, "\n")