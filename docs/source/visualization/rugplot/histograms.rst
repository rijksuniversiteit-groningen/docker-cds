rugplot: Histograms
===================

A histogram is commonly used to visualize an approximation of the
distribution of one-dimensional continuos data. Here some examples are
given to show how to create histograms using the ``rugplot``
container. The famous ``iris dataset``, (`Fisher, 1936`) will be used
to create such examples. The dataset can be downloaded directly from
`DataHub <https://datahub.io/machine-learning/iris>`_, by running
the following command

.. code-block:: console

   wget https://datahub.io/machine-learning/iris/r/iris.csv

or by adding the link in the previous command to the JSON template that will
be created in the first step to create the histogram.

Creating a histogram using the ``rugplot`` container
****************************************************

#. Step 1, create a `rugplot` histogram template

   .. code-block:: console

	docker run --rm -v "$PWD":/app/data venustiano/rugplot:0.1.0 \
	template -p histogram

   as a result

   .. code-block:: json
      :emphasize-lines: 3, 5, 14

      {
          "description": "Parameters to create a histogram(s) using the 'rugplot' R package",
	  "filename": "<filename path>",
	  "variables": null,
	  "y_variable": "<required column name>",
	  "group": null,
	  "colour": null,
	  "fill": null,
	  "facet_row": null,
	  "facet_column": null,
	  "bin_width": 1,
	  "alpha": 0.5,
	  "labels": {
	      "title": null,
	      "subtitle": null,
	      "tag": null,
	      "x": null,
	      "y": null,
	      "colour": null,
	      "fill": null,
	      "caption": null
	  },
	  "rotxlabs": 0,
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
      }
      
   .. code-block:: console

		   'histogram_params.json' template successfully created.
		   Fill in the template to continue.

#. Step 2, update the following values in the template

   .. code-block:: json
      :emphasize-lines: 3, 4, 6

      {
          "description": "Parameters to create a histogram(s) using the 'rugplot' R package",
	  "filename": "https://datahub.io/machine-learning/iris/r/iris.csv",
	  "y_variable": "sepallength",
	  "labels": {
	      "title": "Sepal length histogram",
	  },
      }

#. Step 3, create the histogram

   .. code-block:: console

      docker run --rm -v "$PWD":/app/data -u $(id -u):$(id -g) venustiano/rugplot:0.1.0 \
      plot -p histogram --file histogram_params.json

   The result will be stored in the ``Rplots.pdf`` file.

   .. figure:: ../../_static/Rplots.png-1.png
	       :width: 800
	       :alt: pca projection result
   
   
