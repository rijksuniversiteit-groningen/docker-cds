#!/usr/bin/env Rscript

library(argparse)
library(rugplot)

gdesc <-
"The aim of this program is to provide a tool to quickly create high quality
and customizable visualization plots in three simple steps.

\tFirst, create a JSON template. 
\tSecond, fill in the template. 
\tThird, create the PLOT..

For example, 

1) The following command will create a 'pca_projection_params.json' template

\t./rugplots.R template --plot pca

2) Open the template and fill in the following name/value pairs

\t\"filename\": \"iris.csv\",
\t\"colour\": \"class\",

3) Create the PCA visualization 'plot' which will be stored in Rplots.pdf

\t./rugplots.R plot --plot pca --file pca_projection_params.json



Run './rugplots.R COMMAND --help' for more information on a command.

Visit 
https://docker-cds.readthedocs.io/en/latest/visualization/rugplot/rurgplot.html
for further examples and details.
"

parser <- ArgumentParser(formatter_class= 'argparse.RawTextHelpFormatter', description = gdesc)

subparsers <- parser$add_subparsers(dest='func')


example <- "\n\nExample:\n\n\t./rugplots.R template --plot violin --file myviolin_params.json\n\n"


desc_temp <- paste("Function to save JSON templates for the following types of visualization PLOTs:\n\n\t",
                  paste(list_rugplots(),collapse = '\t'), example)

template_parser <- subparsers$add_parser('template', formatter_class= 'argparse.RawTextHelpFormatter',
                                         description = desc_temp)
template_parser$add_argument('-o','--overwrite', action="store_true",
                        help = 'Overwrite JSON template file')
template_parser$add_argument('-p','--plot', type="character", required = TRUE,
                             help = 'One of the available visualization PLOTs')
template_parser$add_argument('-d','--description', action="store_true", default = FALSE,
                             help = 'Display details of the parameters in the template')
template_parser$add_argument('-f','--file', type="character", default = NULL,
                             help = 'Filename to save the JSON template')


desc_plot <- "This command creates visualization PLOTs using a JSON template. 
The data and attributes of the PLOT are defined in such a template. 
The following PLOTs are available:"

example <- "\n\nExample:\n\n\t./rugplots.R plot --plot violin --file myviolin_params.json\n\n"

desc_plot <- paste(desc_plot,"\n\n\t",paste(list_rugplots(),collapse = '\t'), example)

plot_parser <- subparsers$add_parser('plot', formatter_class= 'argparse.RawTextHelpFormatter',
                                     description = desc_plot)
plot_parser$add_argument('-p','--plot', type="character", required = TRUE,
                           help = 'One of the available PLOTs')
plot_parser$add_argument('-f','--file', type="character", required = TRUE,
                             help = 'JSON template filename')
plot_parser$add_argument('-v', '--verbose', action='store_true', default = FALSE,
                         help = 'Print extra output')

args <- parser$parse_args()

if ( is.null(args$func) ) {
    parser$print_help()
} else if (!args$plot %in% list_rugplots()) {
        stop("Type error: '", args$plot, "' is not an available PLOT!")
} else 
    switch(args$func,
           "template" = {
               if (args$description)
                   rugplot::display_rughelp(args$plot)
               else
                   rugplot::create_rugjson(args$plot,args$file,args$overwrite)
           },
           "plot" = {
               lparams <- rugplot::read_rugjson(args$file,args$plot)
               create_rugplot(lparams, args$plot, verbose=args$verbose)
           }
    )
