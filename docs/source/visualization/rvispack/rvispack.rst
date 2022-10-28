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

will download the Docker image `venustiano/cds:rvispack-0.1.0` from
DockerHub if it is not in the computer host. Then it will run a
container and display information about the `R packages` used to
implement the visualizations. The `Index` section displays the current
implemented functions::

  Index:

  c_histogram             Histogram
  c_pcaproj               PCA projection
  c_violin                Violin plots
  validate_json_file      This function validates a json structure
  validate_parameters     Validate that a json file meets a required
                          schema

The `c_` prefix in the function name stands for containerized and
receives a `JSON <https://www.json.org/json-en.html>`_ file name as a
parameter. This file must contain information such as the data file,
the parameters of the `visualization` technique and the output
formats. Finally, the container will stop running and the `--rm` flag
will remove it.

Help
++++

The required `name/value` pairs in the JSON file can be displayed by
adding `<c_function_name> help` in the previous command, as follows::

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
description includes the data types as defined in the `JSON
<https://www.json.org/json-en.html>`_ format. Below is an example of
valid JSON file (`pca_iris_params.json`)::
   
   {
       "filename": "iris.csv",
       "col_ids":["sepal_length","sepal_width","petal_length","petal_width","species"],
       "colour": "species",
       "scale": true,
       "biplot": true,
       "height": 10,
       "width": 15,
       "title": "Iris PCA projection",
       "save":true,
       "device":"png",
       "interactive":false
   }

Volumes
+++++++

To access the data and the JSON file, a folder in the filesystem must
be mounted in the container. A common way to achieve this is by
passing an argument like `-v "$PWD":/app/data` in the command as
follows::
   
  docker run --rm -v "$PWD":/app/data venustiano/cds:rvispack-0.1.0 c_pcaproj pca_iris_params.json

`-v` is just an abbreviation of `--volume`. The content of `$PWD`
(working directory) including the JSON and data files will be
available in the container in the folder `/app/data` in the container.

.. note::

   Under Windows if not using WSL, preferably use Powershell and
   change `"$PWD"` by `${PWD}`.

.. warning::

   Do not change the `/app/data` mounting point.

The result of running the previous command is the following
visualization.
  
.. figure:: ../../_static/iris.csv-pca-20221027_210622.png
  :width: 800
  :alt: pca projection result

Setting `"interactive"` to `true` in `pca_iris_params.json` will
generate an interactive visualization::

  ...
  "interative":true
  ...

.. raw:: html
	 
	 <iframe src="../../_static/iris.csv-pca-20221028_074618.html" height="500px" width="100%"></iframe>
	
Singularity
***********

UNDER CONSTRUCTION
