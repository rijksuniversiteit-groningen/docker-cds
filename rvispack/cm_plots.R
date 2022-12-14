#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# Copyright (c) University of Groningen Data Science Team
# Distributed under the terms of the Apache License 2.0

# library(rutils)
library(rvispack)

# test if there are at least two arguments: if not, return an error
if (length(args)==0) {
  help(package=rvispack)
} else if (length(args)>=2) {
  plottype <- args[1]
  parameters <- args[2]

  if (parameters == "help" || parameters == "dhelp")
    switch(parameters,
     "help" = switch( plottype,
                      "c_histogram" = ?c_histogram,
                      "c_violin" =    ?c_violin,
                      "c_pcaproj" = ?c_pcaproj,
                      cat(paste0("'",plottype,"' plot is not found in this package"))
                      ),
     "dhelp"= switch( plottype,
                      "c_histogram" = rutils::display_schema("histogram_schema.json",cds_package="rvispack"),
                      "c_violin" =    rutils::display_schema("violin_schema.json",cds_package="rvispack"),
                      "c_pcaproj" = rutils::display_schema("pca_projection_schema.json",cds_package="rvispack"),
                      cat(paste0("'",plottype,"' detailed schema not found in this package"))
                      )
    )
  else {
    # reading and validating the list of parameters
    cat(paste("Opening  parameters file:",parameters))
    lparams <- rutils::validate_json_file(parameters)

    switch( plottype,
          "c_histogram" = {
                          # validating the parameters against the histogram json schema
                          rutils::validate_parameters(parameters,pschema="histogram_schema.json")
                          c_histogram(lparams)
                        },
          "c_violin" = {
                       # validating the parameters against the violin json schema
                        rutils::validate_parameters(parameters,pschema="violin_schema.json")
                        c_violin(lparams)
                     },
          "c_pcaproj" =  {
                    # validating parameters against the pca json schema
                    rutils::validate_parameters(parameters)
                    c_pcaproj(lparams)
                  },
          cat(paste0("'",plottype,"' plot is not found in this package"))
          )
	  }
}


# Rscript cm_plots.R <plot type> <path/parameters.json>
# Rscript cm_plots.R <plot type> help
