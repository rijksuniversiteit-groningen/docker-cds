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
programming skills``. `rugplot` can be used in three ways, via an R
package hosted in `this GitHub repository
<https://github.com/rijksuniversiteit-groningen/rugplot>`_, via a
command line interface (CLI) using Docker or Apptainer, and by means
of a graphical user interface.

As ``rugplot`` is implemented using ggplot2, it is inline with the
concept of `The Grammar of Graphics
<https://bookdown.org/alhdzsz/data_viz_ir/ggbasics.html>`_. Thus,
elements such as ``Data``, ``Aesthetics`` and ``Facets`` are
considered in the creation of plots.

Here it is described the use of ``rugplot`` via the CLI. The commands
have two parts, the `Docker` and the `rugplot`.

.. _docker-lab:

Docker commands
+++++++++++++++

The Docker part will be most of the time as follows:

.. tabs::

   .. tab:: linux
	    
      .. code-block:: console
		
         docker run --rm -v "$PWD":/app/data -u $(id -u):$(id -g) venustiano/rugplot:0.1.0

   .. tab:: PowerShell
	    
      .. code-block:: powershell
		
         docker run --rm -v ${PWD}:/app/data venustiano/rugplot:0.1.0
      
The command will download the Docker image
``venustiano/rugplot:0.1.0`` from DockerHub if it is not in the
computer host. The ``--rm`` flag will remove the container when the
visualization task is done. The argument ``-v "$PWD":/app/data`` will
mount the current working directory in the `/app/data` folder within
the container. This will enable `rugplot` to use data to create the
visualizations.

.. note::

   Running the command ``ls`` will display the files in the working
   directory

The ``-u $(id -u):$(id -g)`` argument will give the
ownership of the results to the current user.

The ``rugplot`` alias
~~~~~~~~~~~~~~~~~~~~~

As this is a `long` and `complex` command, it is a good idea to create
an alias. An ``alias`` is a simplified way to reference another
command. `Aliases <https://linuxhandbook.com/linux-alias-command/>`_
can be created under ``*nix`` operating systems:


.. tabs::

   .. tab:: linux

      .. code-block:: console

	  alias rugplot='docker run --rm -v "$PWD":/app/data \
                        -u $(id -u):$(id -g) venustiano/rugplot:0.1.0'
   .. tab:: Powershell
   
      .. todo::

          `Write a function
          <https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions?view=powershell-7.3>`_,
          as aliases can not have arguments in PowerShell.

.. note::

   This alias is temporary. If you exit the shell, you’ll lose the
   alias. If you want to make the alias permanent, follow this
   `link <https://linuxhandbook.com/linux-alias-command/>`_.

.. note::

   Under Powershell use `${PWD}` instead of `"$PWD"`.

.. warning::

   Do not change the `/app/data` mounting point.

The ``rugplot`` commands
++++++++++++++++++++++++

Based on standards and conventions, `rugplot` use the following special
characters in the command descriptions.

- Brackets ([ ]), indicate optional parameters and arguments.
- Braces ({ }), indicate a required choice between two or more options or arguments.
- Ellipsis (...), indicate repetition or multiple values or arguments.

The command

.. tabs::

   .. tab:: alias

      .. code-block:: console

	 rugplot

   .. tab:: raw command

      .. code-block:: console

	 docker run --rm venustiano/rugplot:0.1.0

   .. tab:: PowerShell

      .. code-block:: powershell

	 docker run --rm venustiano/rugplot:0.1.0
	 
will display information to create visualizations:

.. code-block:: console
   :emphasize-lines: 1
   :caption: ``rugplot help``
   :name: rughelp

   usage: ./rugplots.R [-h] {template,plot} ...

   The aim of this program is to provide a tool to quickly create high
   quality and customizable visualization plots in three simple steps.

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
subcommand either ``template`` or ``plot``, and other arguments (...).

.. note ::

  The ``rugplot.R`` script does not have to be specified in the
  ``rugplot`` container commands, because it is given by default when
  the container runs. See the :ref:`template-lab` and the
  :ref:`plot-lab` subsections.

.. note ::

  To be able to run the steps in :ref:`rughelp` we need to add the
  volume argument in the command, as described in the
  :ref:`docker-lab` section.
       
.. _template-lab:

The ``template`` subcommand
~~~~~~~~~~~~~~~~~~~~~~~~~~~

The `template` subcommand is used to create a JSON template in the
first step to create a visualization plot using the `rugplot`
container. The subcommand options can be found using the ``--help``
argument:

.. tabs::

   .. tab:: alias

      .. code-block:: console

	 rugplot template --help

   .. tab:: raw command

      .. code-block:: console

 	 docker run --rm venustiano/rugplot:0.1.0 template --help

   .. tab:: PowerShell

      .. code-block:: powershell

 	 docker run --rm venustiano/rugplot:0.1.0 template --help
	 
Usage, types of visualizations available and an example will also be
displayed:

.. code-block:: console
   :emphasize-lines: 1

   usage: /app/bin/rugplots.R template [-h] [-o] -p PLOT [-d] [-f FILE]

   Function to save JSON templates for the following types of
   visualization PLOTs:

	 histogram	pca	violin 

   Example:

	./rugplots.R template --plot violin --file myviolin_params.json

   options:
    -h, --help            show this help message and exit
    -o, --overwrite       Overwrite JSON template file
    -p PLOT, --plot PLOT  One of the available visualization PLOTs
    -d, --description     Display details of the parameters in the template
    -f FILE, --file FILE  Filename to save the JSON template

The ``usage`` highlighted line shows that this subcommand requires the
``--plot PLOT`` argument and an optional ``--file FILE`` argument. If
no file argument is given, a `PLOT_params.json` file is
generated. Where ``PLOT`` is one of the available visualization plots.

The following `docker/rugplot` command will create a
`my_violin_params.json` file for a `violin` plot:

.. tabs::

   .. tab:: alias

      .. code-block:: console

         rugplot template -p violin -f myviolin_params.json

   .. tab:: raw command
	    
      .. code-block:: console
         :emphasize-lines: 2

	 docker run --rm -v "$PWD":/app/data -u $(id -u):$(id -g) venustiano/rugplot:0.1.0 \
	 template -p violin -f myviolin_params.json

   .. tab:: PowerShell
	    
      .. code-block:: powershell
         :emphasize-lines: 2

	 docker run --rm -v ${PWD}:/app/data venustiano/rugplot:0.1.0 ` 
	 template -p violin -f myviolin_params.json
	 
	 
The first part of the command (docker) runs a
`venustiano/rugplot:0.1.0` container and will be the same for all the
plots created with ``rugplot``, except when running a different
version than ``0.1.0``. For the highlighted second part, the ``-f``
argument indicates that it will create the `myviolin_params.json`
file and the ``-p`` argument indicates that it will be a `violin` plot
template.

The JSON file contains the default values of the visualization plot
parameters. However, required parameters identified between angle
brackets ``<>`` must be provided. For example, among other
``name/value`` pairs, `myviolin_params.json` will require the
following values:

.. code-block:: json

    {
	"filename": "<filename path>",
	"y_variable": "<Y required column name>",
    }

.. note::

   A `JSON <https://www.json.org/json-en.html>`_ object is an
   unordered set of ``name/value`` pairs. An object begins with ``{``
   left brace and ends with ``}`` right brace. Each ``name`` is
   followed by ``:`` colon and the ``name/value`` pairs are separated by
   ``,`` comma.

It is expected the name/value pairs to be intuitive for the users. In
other case, the optional argument ``-d`` or ``--description`` will
display additional details about the pairs in a `JSON Schema
<https://json-schema.org/understanding-json-schema/reference/index.html>`_
including description, type and default values. For example, the
following command will display the JSON schema for a violin plot:

.. tabs::

   .. tab:: alias

      .. code-block:: console

	 rugplot template -p violin -d

   .. tab:: raw command

      .. code-block:: console

	 docker run --rm venustiano/rugplot:0.1.0 template -p violin -d

   .. tab:: PowerShell

      .. code-block:: powershell

	 docker run --rm venustiano/rugplot:0.1.0 `
	 template -p violin -d

In the output of the command, the ``device`` property shows the
information in the box below, where ``"enum"`` indicates the possible
output formats.

.. code-block:: json
   :caption: ``File formats``
   :name: device-lab
	  
   "device": {
	"title": "Device",
        "description": "File format, note: 'tikz' produce a LaTeX-pdf file",
	"type": "string",
        "enum": [ "eps", "ps", "tex", "pdf", "jpeg", "tiff",
	        "png", "bmp", "svg", "html","tikz"],
	"default": "pdf"
   },

.. _plot-lab:

The ``plot`` subcommand
~~~~~~~~~~~~~~~~~~~~~~~

The `plot` subcommand is used in the third and last step to create
visualizations using the ``rugplot`` container. The ``--help`` option
shows the usage, description, available PLOTs and an usage example.

.. tabs::

   .. tab:: alias

      .. code-block:: console

	 rugplot plot --help

   .. tab:: raw command

      .. code-block:: console

	 docker run --rm venustiano/rugplot:0.1.0 plot --help

   .. tab:: PowerShell

      .. code-block:: powershell

	 docker run --rm venustiano/rugplot:0.1.0 plot --help
	 
As a result:
	
.. code-block:: console
   :emphasize-lines: 1
		     
	usage: /app/bin/rugplots.R plot [-h] -p PLOT -f FILE [-v]

	This command creates visualization PLOTs using a JSON template. 
	The data and attributes of the PLOT are defined in such a template. 
	The following PLOTs are available: 

		histogram	pca	violin 

	Example:

		./rugplots.R plot --plot violin --file myviolin_params.json

	options:
		-h, --help            show this help message and exit
		-p PLOT, --plot PLOT  One of the available PLOTs
		-f FILE, --file FILE  JSON template filename
		-v, --verbose         Print extra output

The first line in the result ``usage`` shows that this subcommand
requires two positional arugments ``-p`` or ``--plot`` followed by the
type of plot to be created and and ``-f`` or ``--file`` followed by
the JSON file created using the ``template`` subcommand (see the
:ref:`template-lab` section). The command to create a visualization
would be as follows:

.. tabs::

   .. tab:: alias

      .. code-block:: console

	 rugplot plot -p violin -f myviolin_params.json

   .. tab:: raw command
	    
      .. code-block:: console

	 docker run --rm -v "$PWD":/app/data -u $(id -u):$(id -g) venustiano/rugplot:0.1.0 \
	 plot -p violin -f myviolin_params.json

   .. tab:: PowerShell
	    
      .. code-block:: powershell

	 docker run --rm -v ${PWD}:/app/data venustiano/rugplot:0.1.0 `
	 plot -p violin -f myviolin_params.json
	 

``rugplot`` file format output
++++++++++++++++++++++++++++++

Currently, the folowing ``values`` are available to customize the
output.

.. code-block:: json

    "save": {
        "save": false,
        "outputfilename": null,
        "overwrite": false,
        "width": 15,
        "height": 10,
        "dpi": 72,
        "device": "pdf",
        "sanitize": true
    }

If ``"save"`` is ``false``, the result will be stored by default in
the ``Rplots.pdf`` and the rest of the `values` will have no
effect. If ``"save"`` is ``true`` and ``"outputfilename"`` is
``null``, the file name will have the following format::

  <datafilename>-<PLOT>-<YYYYMMDD>_HHMMSS.msec.<file_format>

Where PLOT represents the kind of plot created. Violin plots created
using the "iris.csv" data file would be saved in the following file:

.. code-block:: console

  iris.csv-violin-20230130_173149.929.pdf

The visualization formats that can be created using the ``rugplot``
container can be found in the JSON schemas for each visualization
plot, as shown in the :ref:`device-lab` box. The ``html`` file format
creates an interactive visualization using ggplotly (for instance,
this :ref:`interactive-lab`) and the ``tikz`` device option
produces high quality LaTeX visualizations using the ``tikzDevice`` R
package (for instance this :ref:`Figure <tikz figure>`).
   
Singularity
***********

.. todo::

   Write documentation for creating `rugplot` visualizations using singularity.


.. toctree::

   gui/rugplotgui
   histograms
   violinplots
   pcaprojections
   scatterplots
   heatmaps

