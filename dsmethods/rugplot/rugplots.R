#!/usr/bin/env Rscript

library(argparse)
library(rugplot)

gdesc <- "This program can create visualization PLOTs in three steps. First, create a
a JSON template using the COMMAND 'template'. Second, fill in the template adding the
data source file name and other attributes to create the visualization. You can display
the attribute details using the COMMAND 'schema'. Third, run the 'plot' COMMAND using
'-p PLOT' and '-f FILE' as arguments, where FILE is the JSON template file and PLOT is
one of the following: \n\n"

# gdesc <- paste0(gdesc,paste(names(rug_plots_list),collapse = ', '),
gdesc <- paste0(gdesc, paste(list_rugplots(), collapse = ', '),
               "\n\nRun './rugplots.r COMMAND --help' for more information on a command.")


parser <- ArgumentParser(formatter_class= 'argparse.RawTextHelpFormatter', description = gdesc)
# parser$add_argument('-v', '--verbose', action='store_true')

subparsers <- parser$add_subparsers(dest='func')

desc_temp <- paste("Function to save JSON templates for the following types of visualization PLOTs:",
                  paste(list_rugplots(),collapse = ', '))

template_parser <- subparsers$add_parser('template',description = desc_temp)
template_parser$add_argument('-o','--overwrite', action="store_true",
                        help = 'Overwrite JSON template file')
template_parser$add_argument('-p','--plot', type="character", required = TRUE,
                             help = 'One of the PLOTs in the description')
template_parser$add_argument('-f','--file', type="character", default = NULL,
                             help = 'Filename to save the JSON template')

desc_schema <- paste("Function to display description of the parameters for the following PLOTs:\n\n",
                   paste(list_rugplots(),collapse = ', '))

schema_parser <- subparsers$add_parser('schema', description = desc_schema)
schema_parser$add_argument('-p','--plot', type="character", required = TRUE,
                           help = 'One of the PLOTs in the description')

desc_plot <- "This command creates visualization PLOTs. It requires a JSON template
created by the 'template' command. The data and attributes of a PLOT are defined in such
a template. The following 'rug' plots are available:"

desc_plot <- paste0(desc_plot,"\n\n",paste(list_rugplots(),collapse = ', '))

plot_parser <- subparsers$add_parser('plot', description = desc_plot)
plot_parser$add_argument('-p','--plot', type="character", required = TRUE,
                           help = 'One of the PLOTs in the description')
plot_parser$add_argument('-f','--file', type="character", required = TRUE,
                             help = 'JSON template filename')
plot_parser$add_argument('-v', '--verbose', action='store_true', default = FALSE,
                         help = 'Print extra output')

args <- parser$parse_args()

if (!args$plot %in% list_rugplots())
  stop("Type error: '", args$plot, "' is not a rugplot!")

switch(args$func,
       "template" = {
            rugplot::create_rugjson(args$plot,args$file,args$overwrite)
       },
       "schema" = {
           rugplot::display_rughelp(args$plot)
       },
       "plot" = {
         lparams <- rugplot::read_rugjson(args$file,args$plot)
         create_rugplot(lparams, args$plot, verbose=args$verbose)
       }
)

