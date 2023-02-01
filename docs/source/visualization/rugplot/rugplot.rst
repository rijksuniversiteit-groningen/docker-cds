rugplot: ReUsable Graphics
==========================

Assumptions
***********

- `Docker <https://docs.docker.com/get-docker/>`_ or `Singularity
  <https://docs.sylabs.io/guides/3.5/user-guide/introduction.html>`_ are
  installed.

Basics
------

The ``rugplot`` Docker container is a ``user-friendly tool`` to easily
and quickly generate data visualization plots ``without the need for
programming skills``. Currently, `rugplot` can be used in two ways,
via an R package hosted in `this GitHub repository
<https://github.com/rijksuniversiteit-groningen/rugplot>`_ and a via a
command line interface (CLI) using Docker containers or
Singularity. Here it is described the use of ``rugplot`` via
the CLI. The commands have two parts, the `Docker` and the
`RuGplot`.

Docker

The Docker part will be most of the time as follows::

  docker run --rm -v "$PWD":/app/data venustiano/rugplot:0.1.0

The command will download the Docker image
``venustiano/rugplot:0.1.0`` from DockerHub if it is not in the
computer host. The ``--rm`` flag will remove the container when the
visualiztion task is done. The argument ``-v "$PWD":/app/data`` will
mount the current working directory in the `/app/data` folder within
the container.

.. note::

   It is important that the data are in the working directory.

.. note::

   Under Powershell use `${PWD}` instead of `"$PWD"`.

.. warning::

   Do not change the `/app/data` mounting point.

RuGplot

Based on standards and conventions, `rugplot` use the following special
characters in the command descriptions.

- Brackets ([ ]), brackets indicate optional parameters and arguments.
- Braces ({ }), braces indicate a required choice between two or more options or arguments.
- Ellipsis (...), ellipses indicate repetition or multiple values or arguments.



The command
::

   docker run --rm venustiano/rugplot:0.1.0

will display information to create visualizations in three steps::

  usage: /app/bin/rugplots.R [-h] {template,plot} ...

  The aim of this program is to provide a tool to quickly create high quality
  and customizable visualization plots in three simple steps.

        First, create a JSON template. 
	Second, fill in the template. 
	Third, run the 'plot' COMMAND.

  For example, 

  1) The following command will create a 'pca_projection_params.json' template

	./rugplots.R template --plot pca

  2) Open the template and fill in the following name/value pairs

	"filename": "iris.csv",
	"colour": "species",

  3) Run the 'plot' command to generate the PCA plot in Rplots.pdf

	./rugplots.R plot --plot pca --file pca_projection_params.json

  Run './rugplots.R COMMAND --help' for more information on a command.


  
The first line ``usage`` indicates that the ``rugplot.R`` script will
be executed receiving the optional ``[-h]`` help argument and a required
subcommand either ``template`` or ``plot``.

The ``template`` SUBCOMMAND
+++++++++++++++++++++++++++

The `template` subcommand is used in the first step to create a JSON
template. The different options can be found using the ``help``
argument::

  docker run --rm venustiano/rugplot:0.1.0 template --help

Usage, types of visualizations available and an example will also be
displayed:

.. code-block:: console

  usage: /app/bin/rugplots.R template [-h] [-o] -p PLOT [-d] [-f FILE]

  Function to save JSON templates for the following types of visualization PLOTs:

	 histogram	pca	violin 

  Example:

	./rugplots.R template --plot violin --file myviolin_params.json

  options:
    -h, --help            show this help message and exit
    -o, --overwrite       Overwrite JSON template file
    -p PLOT, --plot PLOT  One of the available visualization PLOTs
    -d, --description     Display details of the parameters in the template
    -f FILE, --file FILE  Filename to save the JSON template

As shown in the ``usage`` line, this subcommand requires the ``--plot
PLOT`` argument, without any other argument, a `PLOT_params.json` file
is generated. Where ``PLOT`` is one of the available visualization
plots. This JSON file contains the default values of the visualization
plot parameters. However, required parameters identified between angle
brackets ``<>`` must be provided.

.. note::

   A `JSON <https://www.json.org/json-en.html>`_ object is an
   unordered set of `name/value` pairs. An object begins with `{` left
   brace and ends with `}` right brace. Each `name` is followed by `:`
   colon and the `name/value` pairs are separated by `,` comma.

It is expected that the name/value pairs to be intuitive for the
users. In other case, the optional argument ``-d`` or ``-description``
will display additional details about the pairs in a `JSON Schema
<https://json-schema.org/understanding-json-schema/reference/index.html>`_
including description, type and default values. For example, the
following command will display the JSON schema for a violin plot::

  docker run --rm venustiano/rugplot:0.1.0 template -p violin -d

In the output of command, the ``device`` property shows the
information in the box below, where ``"enum"`` indicates the possible
output formats.

.. code-block:: json

   "device": {
	"title": "Device",
        "description": "File format, note: 'tikz' produce a LaTeX-pdf file",
	"type": "string",
        "enum": [ "eps", "ps", "tex", "pdf", "jpeg", "tiff",
	        "png", "bmp", "svg", "html","tikz"],
	"default": "pdf"
   },

The ``plot`` SUBCOMMAND
+++++++++++++++++++++++

The `plot` command




A brief description of the `name/value` pairs that could be in the
JSON file are displayed in the `Arguments` section.


The `names` in the JSON file are between double quotes and the
description of the `values` are between angle brackets. This
description includes the data types as defined in the `JSON
<https://www.json.org/json-en.html>`_ format. Below is an example of a
valid JSON file (`pca_iris_params.json`)::
   
   {
       "filename": "iris.csv",
       "colour": "species",
       "scale": true,
       "biplot": true,
       "title": "Iris PCA projection"
   }

JSON objects and name/value pairs
+++++++++++++++++++++++++++++++++



`Name/value` pairs in the JSON objects are validated by means of `JSON
schemas
<https://json-schema.org/understanding-json-schema/index.html>`_. Here
will be described the essential name/value pairs to run the functions
to create visualizations using `rvispack`. See the `JSON Schema
Reference
<https://json-schema.org/understanding-json-schema/reference/index.html>`_
for additional information.

The description of the values (between<>) indicate the `type` of
`value`, namely `string`, `number`, `integer`, `object`, `array` and
`boolean`.

- The `"string"` type is used for strings of text.
- The `number` type is used for integers or floating point numbers.
- The `integer` type is used for integran numbers (no decimal point).
- The `boolean` type matches only `true` or `false`.
- The `array` type is used for ordered elements.
- The `enum` keyword is used to restrict a value to a fixed set of
  values defined in an `array`.
- The `object` type is used to map `"names"` to `"values"`. `"names"`
  must always be strings. In the arguments of the `c_pcaproj`
  function, `"save"` is a nested JSON object including 4 `name/value`
  pairs. As an example, the JSON `save` object can be defined as
  follows::

        ...
        "save":{
	    "save": true,
	    "width": 15,
	    "height": 10,
	    "device": "png"
	  }
	}

Volumes
+++++++

For the visualization functions to access the data and the JSON file,
a folder in the filesystem must be mounted in the container. A common
way to achieve this is by passing an argument like `-v
"$PWD":/app/data` in the command as follows::
   
  docker run --rm -v "$PWD":/app/data venustiano/cds:rvispack-0.1.0 c_pcaproj pca_iris_params.json

`-v` is just an abbreviation of `--volume`. The content of the working
directory (`$PWD`) including the JSON and data files will be available
in the container in the folder `/app/data`.

.. note::

   Under Windows if not using WSL, preferably use Powershell and
   change `"$PWD"` by `${PWD}`.

.. warning::

   Do not change the `/app/data` mounting point.

The result of running the previous command is the following
visualization stored in a `Rplot.pdf` file.
  
.. figure:: ../../_static/iris.csv-pca-20221027_210622.png
  :width: 800
  :alt: pca projection result

Setting `"interactive"` to `true` in `pca_iris_params.json` will
generate an interactive visualization::
  
  ...
       "title": "Iris PCA projection",
       "interative":true
   }

.. raw:: html
	 
	 <iframe src="../../_static/iris.csv-pca-20221028_074618.html" height="500px" width="100%"></iframe>
	
Singularity
***********

.. todo::

   Write documentation for running `rvispack` visualizations using singularity.

..
   .. toctree::

      histograms
      pcaprojections
      violinplots
