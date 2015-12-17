# Functions that deal with annotation objects created by openNLP annotators.

library(NLP)
library(openNLP)
library(openNLPmodels.en)

extractProperNouns <- function(words, str) {
  # find proper nouns (including plural)
  # input: words - openNLP annotation object with only "word" types (no "sentence"s)
  #        str - original string to extract nouns from
  # output: subset of input words that are Proper Nouns
  export_nouns = c()
  for (i in 1:length(words)) {
    word = words[[i]]
    if ("NNP" %in% word$features[[1]] | "NNPS" %in% word$features[[1]]) {
      export_nouns = c(export_nouns, substr(str, word$start, word$end))
    }
  }
  return(export_nouns)
}