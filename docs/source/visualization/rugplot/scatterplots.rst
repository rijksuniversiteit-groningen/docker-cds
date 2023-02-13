rugplot: Scatter plots
======================

A scatter plot is commonly used to visualize the relationship between
two variables. Here some examples are given to show how to create
scatterplots using the ``rugplot`` container. The famous ``iris
dataset``, (`Fisher, 1936`) will be used to create such examples. The
dataset can be downloaded directly from `DataHub
<https://datahub.io/machine-learning/iris>`_, by running the following
command

.. tabs::

   .. tab:: Linux

	    .. code-block:: console

			    wget https://datahub.io/machine-learning/iris/r/iris.csv

   .. tab:: PowerShell

	    .. code-block:: powershell

	       Invoke-WebRequest https://datahub.io/machine-learning/iris/r/iris.csv -OutFile iris.csv

			    
or by adding the link in the previous command to the JSON template that will
be created in the second step to create the histogram.

Creating a scatter plot using the ``rugplot`` container
*******************************************************

For simplicity it is better to create an ``alias``, see the
:ref:`docker-lab` section.

#. Step 1, create a `rugplot` histogram template

   .. tabs::

      .. tab:: alias

	 .. code-block:: console

	    rugplot template -p scatter

      .. tab:: raw command
   
	 .. code-block:: console

	    docker run --rm -v "$PWD":/app/data -u $(id -u):$(id -g) venustiano/rugplot:0.1.0 \
	    template -p scatter

      .. tab:: PowerShell
   
	 .. code-block:: powershell

	    docker run --rm -v ${PWD}:/app/data venustiano/rugplot:0.1.0 `
	    template -p scatter

   A ``scatter_params.json`` file will be created including some of
   the `name/value` pairs listed below:

   .. code-block:: json

      {
          "description": "Parameters to create a scatter plot using the 'rugplot' R package",
	  "filename": "<filename path>",
	  "variables": null,
	  "aesthetics": {
              "y_variable": "<Y required column name>",
              "x_variable": "<X required column name>",
	      "colour": null,
          },
	  "labels": {
	      "title": null,
	      "subtitle": null,
	  },
      }

#. Step 2, add the ``'data file'``, ``'x and y variables'``,
   ``'title'``, and ``'colour'`` values in the template:

   .. code-block:: json

      {
	  "filename": "https://datahub.io/machine-learning/iris/r/iris.csv",
	  "aesthetics": {
	      "y_variable": "sepallength",
              "x_variable": "sepalwidth",
	      "colour": "class",
          },
	  "labels": {
	      "title": "width vs length",
	  },
      }

#. Step 3, create the histogram

   .. tabs::

      .. tab:: alias

	 .. code-block:: console

	    rugplot plot -p scatter --file scatter_params.json

      .. tab:: raw command
	       
	 .. code-block:: console

	    docker run --rm -v "$PWD":/app/data -u $(id -u):$(id -g) venustiano/rugplot:0.1.0 \
            plot -p scatter --file scatter_params.json

      .. tab:: PowerShell
	       
	 .. code-block:: powershell

	    docker run --rm -v ${PWD}:/app/data venustiano/rugplot:0.1.0 `
            plot -p scatter --file scatter_params.json

   The result will be stored in the ``Rplots.pdf`` file.

   .. figure:: ../../_static/scatter_iris.png
	       :height: 400
	       :alt: scatter plot
   
