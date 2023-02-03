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

.. code-block:: console

   wget https://datahub.io/machine-learning/autos/r/autos.csv

or by adding the link in the previous command to the JSON template that will
be created in the second step to create the histogram.

Creating violin plots using the ``rugplot`` container
*****************************************************

#. Step 1, create a `rugplot violin`` JSON template

   .. code-block:: console

	docker run --rm -v "$PWD":/app/data -u $(id -u):$(id -g) venustiano/rugplot:0.1.0 \
	template -p violin

   A ``violin_params.json`` file will be created including some of
   the `name/value` pairs listed below:

   .. code-block:: json

      {
          "description": "Parameters to create violin plots using the 'rugplot' R package",
	  "filename": "<filename path>",
	  "y_variable": "<Y required column name>",
	  "x_variable": null,
	  "colour": null,
	  "fill": null,
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
	  "y_variable": "highway-mpg",
	  "x_variable": "body-style",
	  "colour": "body-style",
	  "fill": "body-style",
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

   .. code-block:: console

      docker run --rm -v "$PWD":/app/data -u $(id -u):$(id -g) venustiano/rugplot:0.1.0 \
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

   .. figure:: ../../_static/Rplots.png-1.png
	       :height: 400
	       :alt: pca projection result
   
   
Customizing the histogram
*************************

Different ttributes can be customized such as other labels, colours
and file format. For example, adding the values below (to save space,
only the updated ``name/value`` are listed) in
``histogram_params.json``

.. code-block:: json

    "colour": "class",
    "labels": {
        "x": "Sepal length",
    },
    "save": {
        "save": true,
        "outputfilename": "sepal-length_histogram.png",
        "device": "png",
    }

and running the ``exactly same`` command in step 3 will produce the
following visualization stored in a ``png`` file.

   .. figure:: ../../_static/sepal-length_histogram.png
	       :alt: pca projection result

The `png` file has the default size 10x15 cm (height/width) and 72
dots per inch. These properties can be changed in the ``"save"``
attributes of the JSON file.

Other properties can also be added such as facets, interactive plots
and LaTeX tikDevice plots.
