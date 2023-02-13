rugplot: Violin Plots
=====================

Similar to histograms, violin plos are used to used to visualize an
approximation of the distribution of one-dimensional continuos
data. However, instead of showing bars, violin plots adjust a
probability density function to fit a curve on the histogram, then the
curve is rotated 90 degrees and finally reflected. Here we show how to
create violin plots using the ``rugplot`` container. The famous ``Auto
Imports Database``, (`Jeffrey, 1936`) will be used, such dataset can
be downloaded directly from `DataHub autos
<https://datahub.io/machine-learning/autos>`_, by running the
following command

.. tabs::

   .. tab:: Linux

	    .. code-block:: console

			    wget https://datahub.io/machine-learning/autos/r/autos.csv

   .. tab:: PowerShell

	    .. code-block:: powershell

	       Invoke-WebRequest https://datahub.io/machine-learning/autos/r/autos.csv -OutFile autos.csv

   
or by adding the link in the previous command to the JSON template that will
be created in the second step to create the histogram.

Creating violin plots using the ``rugplot`` container
*****************************************************

For simplicity it is better to create an ``alias``, see the
:ref:`docker-lab` section.

#. Step 1, create a `rugplot violin`` JSON template

   .. tabs::

      .. tab:: alias

	 .. code-block:: console

	    rugplot template -p violin

      .. tab:: raw command
	       
	 .. code-block:: console

	    docker run --rm -v "$PWD":/app/data -u $(id -u):$(id -g) venustiano/rugplot:0.1.0 \
	    template -p violin

      .. tab:: PowerShell
	       
	 .. code-block:: powershell

	    docker run --rm -v ${PWD}:/app/data venustiano/rugplot:0.1.0 `
	    template -p violin
	    
   A ``violin_params.json`` file will be created including some of
   the `name/value` pairs listed below:

   .. code-block:: json

      {
          "description": "Parameters to create violin plots using the 'rugplot' R package",
	  "filename": "<filename path>",
	  "aesthetics": {
              "y_variable": "<Y required column name>",
	      "x_variable": "''",
	      "fill": null,
	      "colour": null,
	  },
	  "boxplot": {
	      "addboxplot": false,
	  },
	  "rotxlabs": 0,
	  "save": {
              "save": false,
              "dpi": 72,
              "device": "pdf",
	  }
      }


#. Step 2, add the values below to the ``violin_params.json`` file:

   .. code-block:: json

      {
          "description": "Parameters to create violin plots using the 'rugplot' R package",
	  "filename": "https://datahub.io/machine-learning/autos/r/autos.csv",
	  "aesthetics": {
              "y_variable": "highway-mpg",
	      "x_variable": "body-style",
	      "colour": "body-style",
	      "fill": "body-style",
	  },
	  "boxplot": {
	      "addboxplot": true,
	  },
	  "rotxlabs": 45,
	  "save": {
              "save": true,
	      "dpi": 300,
              "device": "png",
	  }
      }

#. Step 3, create the violin plots

   .. tabs::

      .. tab:: alias

	 .. code-block:: console

	    rugplot plot -p violin --file violin_params.json

      .. tab:: raw command
   
	 .. code-block:: console

	    docker run --rm -v "$PWD":/app/data -u $(id -u):$(id -g) venustiano/rugplot:0.1.0 \
	    plot -p violin --file violin_params.json

      .. tab:: PowerShell
   
	 .. code-block:: powershell

	    docker run --rm -v ${PWD}:/app/data venustiano/rugplot:0.1.0 `
	    plot -p violin --file violin_params.json

   The result as follows

   .. error::

      Error in `ggplot2::geom_violin()`:
      
      ! Problem while computing aesthetics.
      
      ℹ Error occurred in the 1st layer.

   .. note::

      Special characters such as ``"-"`` may cause ggplot2 to
      break. In this case the easiest solution is to rename the column
      names ``highway-mpg`` and ``body_style`` to ``highwaympg`` and
      ``bodystyle`` in the ``autos.csv`` file.

   After changing the column names in the ``autos.csv`` file,
   updating the JSON file as follows

   .. code-block:: json

      {
          "filename": "autos.csv",
	  "aesthetics": {
              "y_variable": "highwaympg",
              "x_variable": "bodystyle",
              "fill": "bodystyle",
              "colour": "bodystyle",
	  },	  
      }

   and running the command in step 3 a `png` file with name like
   ``autos.csv-violin-20230203_121603.366.png`` will be saved.
      
   .. figure:: ../../_static/autos.csv-violin-20230203_121603.366.png
	       :height: 400
	       :alt: autos violin plot

A last example in this section is the creation of `tikz LaTeX
<https://texample.net/tikz/examples/feature/plotting/>`_ quality plots
including a LaTeX formula, using the ``tikzDevice`` R package. The
``tikz`` version of the previous looks as follows:

   .. _tikz figure:
   
   .. figure:: ../../_static/autos.csv-violin-tikz.png
	       :alt: violin tikz example

The changes to the JSON template are the following:

.. code-block:: json

   {
	"labels": {
	    "title": "A \\\\\\\\LaTeX formula in the $x$ axis label",
            "x": "$p(x)=\\\\\\\\frac{1}{\\\\\\\\sqrt{2\\\\\\\\pi}}e^{-\\\\\\\\frac{x^2}{2}}$",
	}
       "save": {
           "device": "tikz",
           "sanitize": false
       }
   }

and finally, run the command in step 3 again.

.. note::

   LaTeX commands have to be escaped using ``eight`` backslashes and the
   ``"sanitize"`` property must be set to ``false``.
