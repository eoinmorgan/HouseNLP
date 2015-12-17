# House of Representatives Vocabulary Analysis
## By Eoin Morgan and Andy Quach

### Introduction

This project uses openNLP libraries to extract the frequencies at which the United States House of Representatives refers to proper nouns, according to the floor proceedings XML data found at this URL:

[http://clerk.house.gov/floorsummary/HDoc-114-1-FloorProceedings.xml]()


### Organization
	README.md						# this file
	Skeleton.R 						# setup script
	Report.Rmd						# report generation
	Report.pdf						# pre-generated report
	noun_counts.csv					# precalculated noun frequencies
	code/							(preexisting since it stores our script files)
		DataPrep.R					# fetch raw data and rebuild noun frequencies
		EnvFunctions.R				# update and export env class hash tables
		GrammarFunctions.R			# extract proper nouns from openNLP annotation objects
		StaticVars.R				# environment/static variables
	rawdata/ (generated)
	data/ 							(generated)
		noun_counts.csv 			(copied)
	

### Instructions

**TL;DR - Most of our scripts require signifigant setup/library installation. Check out Report.pdf unless you *really* want to reproduce our work**

We chose to modify the `Skeleton.R` structure slightly to account for the fact that interpreting our raw data is an extremely computationally intensive task that typically takes approximately 1.5 hours to run (on my 2015 Macbook Pro Retina). Instead, the default implementation of this project will use the pre-generated file `noun_coutns.csv`. This can be rebuilt to verify our methods by running `code/DataPrep.R`. Running this script requires a few large packages:

	library(XML)
	library(NLP)
	library(openNLP)
	library(openNLPmodels.en)
	
`openNLPmodels.en` must be downloaded from [http://datacube.wu.ac.at/]() and installed from a `.tar.gz` archive.

We cannot include these package installations as part of our script, since we will not have root access on the instructional machines where the projects are viewed.

We recommend using our pre-generated clean data file instead; it is generated deterministically, so building it again won't cause any changes.

We chose to build our final report as a `.Rmd` file because we felt that it was the best vector to show an evolving, exploratory method of investigation. Once again, we have pre-generated this report, but you can recreate it easily. It does require a few extra packages to be installed:

	library(ggplot2)
	library(ggmap)
	library(wordcloud)
