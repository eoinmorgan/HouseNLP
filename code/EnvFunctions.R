# Functions to build a fast Hash-Table implementation on top of the env
# data class, including writing the table to a file

library(tools)
incrementCount <- function(nouns, env) {
  # uses a hashed r environment to implement fast testing/incrementing of
  # Proper Noun word counts
  # inputs: a Character vector of Proper Nouns, a word count environment
  # output: nothing (environment is modified)
  
  for (noun in nouns) {
    noun_lower = tolower(noun)
    if(!is.null(env[[noun_lower]])) {
      env[[noun_lower]] <- env[[noun_lower]] + 1
    } else {
      env[[noun_lower]] <- 1
    }
  }
}

exportEnvCSV <- function(env, file_name) {
  # exports an environment of noun counts to a well-formed csv table
  # inputs: environment object, file_name path to store the CSV output
  # outputs: None, writes to disk directly
  file.remove(file_name)
  cat(c("name", "count"), file = file_name, sep="\t")
  cat("\n", file = file_name, append= TRUE)
  for (noun in ls(env)) {
    noun_lower = tolower(noun)
    noun_title = toTitleCase(noun)
    cat(c(noun_title, env[[noun_lower]]), file = file_name, sep="\t", append = TRUE)
    cat("\n", file = file_name, append= TRUE)
  }
}