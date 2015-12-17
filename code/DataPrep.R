# A script to download the raw house of representatives data and extract the
# proper noun reference frequencies from it; writes frequencies to a file to
# be used by Report.Rmd in the analysis portion of the project

library(XML)
library(NLP)
library(openNLP)
library(openNLPmodels.en)
source("./StaticVars.R")
source("./GrammarFunctions.R")
source("./EnvFunctions.R")

# raw data acquisition
download.file(data_url, raw_data_file_name, method = "curl", cacheOK = TRUE)
xml = xmlParse(raw_data_file_name)
action_descriptions = getNodeSet(xml, "//action_description")

# openNLP POS tagging setup
sent_token_annotator <- Maxent_Sent_Token_Annotator()
word_token_annotator <- Maxent_Word_Token_Annotator()
pos_tag_annotator <- Maxent_POS_Tag_Annotator()
annotator_list <- list(sent_token_annotator,
                       word_token_annotator,
                       pos_tag_annotator)

# use an env class variable to efficiently store a hash map
all_prop_nouns = new.env()

iteration = 1
for (description in action_descriptions) {
  # Get the description string for a House floor action
  str_val = xmlValue(description)
  str_val = gsub("\n", "", str_val)
  str_val = gsub("\"", "", str_val)
  
  a3 <- annotate(str_val, annotator_list)
  annotate(str_val, Maxent_Chunk_Annotator(), a3)
  annotate(str_val, Maxent_Chunk_Annotator(probs = TRUE), a3)
  
  a3 <- a3[a3$type=="word"]
  prop_nouns = extractProperNouns(a3, str_val)
  
  # increment noun counts
  incrementCount(prop_nouns, all_prop_nouns)
  
  # to make sure the process is still running
  print(iteration)
  iteration = iteration + 1
}

# write frequency table to file
exportEnvCSV(all_prop_nouns, clean_data_file_name)

