library(dplyr)

image_dir <- normalizePath("insert/path/here", winslash = "\\", mustWork = TRUE)

image_files <- list.files(image_dir, pattern = "\\.(jpg|jpeg|png)$", full.names = TRUE, ignore.case = TRUE)

cat("Arquivos encontrados:\n")
cat(image_files, sep = "\n")

extract_registration_code <- function(filename) {
  reg_code <- regmatches(filename, regexpr("[A-Za-z]{3}\\d+", basename(filename)))
  ifelse(length(reg_code) > 0, reg_code, NA)
}

registration_codes <- image_files %>%
  sapply(extract_registration_code) %>%
  na.omit() %>%
  sort()

cat("\nCódigos extraídos:\n")
cat(registration_codes, sep = "\n")

write.table(registration_codes, file = "códigos_de_registro.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)
cat("\nCódigos de registro salvos em 'códigos_de_registro.txt'.\n")