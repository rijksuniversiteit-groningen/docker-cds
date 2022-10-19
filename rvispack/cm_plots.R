#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# Copyright (c) University of Groningen Data Science Team
# Distributed under the terms of the Apache License 2.0 

library(pcaprojection)

# test if there are at least two arguments: if not, return an error
if (length(args)==0) {
  stop("Both 'plot type' and a 'json file' arguments are needed", call.=FALSE)
} else if (length(args)>=2) {
  plottype <- args[1]
  parameters <- args[2]

  if (parameters == "help")
     switch( plottype,
          "histogram" = ?histogram,
          "violin" =    ?cm_ggviolin,
          "pca" = ?pcaproj,
	  cat(paste0("'",plottype,"' plot is not found in this package"))
	  )
  else {
    # reading and validating the list of parameters
    cat(paste("Opening  parameters file:",parameters))
    lparams <- validate_json_file(parameters)

    switch( plottype,
          "histogram" = {
                          # validating the parameters against the histogram json schema
                          validate_parameters(parameters,pschema="histogram_schema.json")
                          histogram(lparams)
                        },
          "violin" = {
                       # validating the parameters against the violin json schema
                       validate_parameters(parameters,pschema="violin_schema.json")
                       cm_ggviolin(lparams)
                     },
          "pca" =  {
                    # validating parameters against the pca json schema
                    validate_parameters(lparams)
                    pcaproj(parameters)
                  },
          cat(paste0("'",plottype,"' plot is not found in this package"))
          )
	  }
}


# Rscript cm_plots.R <plot type> <path/parameters.json>
# Rscript cm_plots.R <plot type> help
