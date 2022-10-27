Creating visualizations with rvispack
=====================================

Assumptions
-----------

- `Docker <https://docs.docker.com/get-docker/>`_ or `Singularity
  <https://docs.sylabs.io/guides/3.5/user-guide/introduction.html>`_ are
  installed.

Basics
------

Docker
******

The command
::
  docker run --rm venustiano/cds:rvispack-0.1.0

Will display information about the `R packages` used to implement the
visualizations. The `Index` section displays the current implemented
functions::
  Index:

  c_histogram             Histogram
  c_pcaproj               PCA projection
  c_violin                Violin plots
  validate_json_file      This function validates a json structure
  validate_parameters     Validate that a json file meets a required
                          schema

The `c_` prefix in the function name stands for containerized and
receives a `JSON <https://www.json.org/json-en.html>`_ file name as a
parameter. This file contains information such as the data file, the
parameters of the `visualization` technique and the output
formats. The required `name/value` pairs in the JSON file can be
displayed by adding `<c_function_name> help` as follows::
  docker run --rm venustiano/cds:rvispack-0.1.0 c_pcaproj help

A brief description of the `name/value` pairs that could be in the
JSON file are displayed in the `Arguments` section::
  Arguments:

      lp: list of parameters in a json file

          "filename": <string, csv file including more than 3 columns>

          "col_ids": <array, numeric columns for applying PCA>

          "colour": <string, categorical variable to colour the
          projected points>

          "scale": <boolean, whether to scale the selected variables>

          "biplot": <boolean, Display biplot (loadings)>

          "height": <number, in cm of the output visualization file>

          "width": <number, in cm of the output visualization file>

          "title": <string, title of the plot>

          "caption": <string, caption of the plot>

          "save": <boolean, save the file?>

          "device": <enum, ["eps", "ps", "tex", "pdf", "jpeg", "tiff",
          "png", "bmp", "svg"]>

          "interactive": <boolean, save Interactive version>

The `names` in the JSON file are between double quotes and the
description of the `values` are between angle brackets. This
description include the data types as defined in the `JSON
<https://www.json.org/json-en.html>`_ format. Below is an example of
valid JSON file.
::
   {
     "filename": "iris.csv",
     "colour": "variety",
     "scale": true,
     "biplot": true,
     "title": "Iris PCA projection"
   }



Singularity
***********
