#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# Copyright (c) University of Groningen Data Science Team
# Distributed under the terms of the Apache License 2.0

library(GeneNetTools)

# test if there are at least two arguments: if not, return an error
if (length(args)==0) {
  help(package=GeneNetTools)
} else if (length(args)>=2) {
  func <- args[1]
  parameters <- args[2]

  if (parameters == "help")
     switch( func,
          "c_pcor_shrunk" = ?c_pcor_shrunk,
          "c_zscore_shrunk" = ?c_zscore_shrunk,
          "c_pval_pcor_shrunk" = ?c_pval_pcor_shrunk,
	  cat(paste0("'",func,"' function is not available\n"))
	  )
  else {
    # reading and validating the list of parameters
    cat(paste("Opening  parameters file:",parameters,"\n"))
    lparams <- validate_json_file(parameters)

    switch( func,
          "c_pcor_shrunk" = {
                          # validating the parameters against the JSON schema
                          validate_parameters(parameters,pschema="pcor_shrunk_schema.json")
                          c_pcor_shrunk(lparams)
                        },
          "c_pval_pcor_shrunk" = {
            # validating the parameters against the JSON schema
            validate_parameters(parameters,pschema="pcor_shrunk_schema.json")
            c_pval_pcor_shrunk(lparams)
          },
          "c_zscore_shrunk" = {
            # validating the parameters against the JSON schema
            validate_parameters(parameters,pschema="zscore_shrunk_schema.json")
            c_zscore_shrunk(lparams)
          },
          cat(paste0("'",func,"' function is not available\n"))
          )
	  }
}


# Rscript c_gene.R <function> <path/parameters.json>
# Rscript c_gene.R <function> help
