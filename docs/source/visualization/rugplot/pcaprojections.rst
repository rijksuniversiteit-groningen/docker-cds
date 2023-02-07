rugplot: PCA Projections
========================

A popular technique to visualize the result of Principal Component
Analysis (PCA) is by means of projections where data with ``m``
columns or variables are projected into a subpace with fewer columns,
typically 2. Here it is shown how to create PCA projections using the
``rugplot`` container.

The famous ``iris dataset``, (`Fisher, 1936`) will be used to create
such examples. The dataset can be downloaded from different sources
and in different ways, three of them are: first, visiting `DataHub
<https://datahub.io/machine-learning/iris>`_, second by running the
following command

.. tabs::

   .. tab:: Linux

	    .. code-block:: console

			    wget https://datahub.io/machine-learning/iris/r/iris.csv

   .. tab:: PowerShell

	    .. code-block:: powershell

	       Invoke-WebRequest https://datahub.io/machine-learning/iris/r/iris.csv -OutFile iris.csv

and third, by adding the link in the previous command to the JSON
template that will be created in the second step for creating a PCA
projection.

Creating a PCA projection plot using the ``rugplot`` container
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

For simplicity it is better to create an ``alias``, see the
:ref:`docker-lab` section.

#. Step 1, create a `rugplot` PCA projection template

   .. tabs::

      .. tab:: alias

	 .. code-block:: console

	    rugplot template --plot pca

      .. tab:: raw command
	    
	 .. code-block:: console

	    docker run --rm -v "$PWD":/app/data -u $(id -u):$(id -g) venustiano/rugplot:0.1.0 \
	    template --plot pca 

      .. tab:: PowerShell
	    
	 .. code-block:: powershell

	    docker run --rm -v ${PWD}:/app/data venustiano/rugplot:0.1.0 `
	    template --plot pca 	    
	    
   A ``pca_projection_params.json`` file will be created including some of
   the `name/value` pairs listed below:

   .. code-block:: json

      {
          "description": "Parameters for a PCA projection using the 'rugplot' R package",
	  "filename": "<filename path>",
	  "colour": null,
	  "labels": {
	      "title": null,
	  },
	  "save": {
              "save": false,
              "outputfilename": null,
              "device": "pdf",
	  }
      }

#. Step 2, add the ``'data file'``, ``'colour'`` and the
   ``'title'`` values in the template:

   .. code-block:: json

      {
	  "filename": "https://datahub.io/machine-learning/iris/r/iris.csv",
	  "colour": "class",
	  "labels": {
	      "title": "Iris PCA projection",
	  },
	  "save": {
              "save": true,
              "outputfilename": "iris-pca.png",
              "device": "png",
	  }
      }

#. Step 3, create the PCA projection plot

   .. tabs::

      .. tab:: alias

	 .. code-block:: console

	    rugplot --plot pca --file pca_projection_params.json

      .. tab:: raw command
   
	 .. code-block:: console

	    docker run --rm -v "$PWD":/app/data -u $(id -u):$(id -g) venustiano/rugplot:0.1.0 \
	    plot --plot pca --file pca_projection_params.json

      .. tab:: PowerShell
   
	 .. code-block:: console

	    docker run --rm -v ${PWD}:/app/data venustiano/rugplot:0.1.0 `
	    plot --plot pca --file pca_projection_params.json
	    
   The result will be stored in the ``Rplots.pdf`` file.

   .. figure:: ../../_static/iris.csv-pca-20221027_210622.png
	       :height: 400
	       :alt: pca projection result


Interactive plots using ``plotly``

   .. code-block:: json
      :caption: ``Interactive plot``
      :name: interactive-lab
	   
      {
	  "labels": {
	      "title": "Interactive iris PCA projection",
	  },
	  "save": {
              "outputfilename": "iris-pca.html",
              "device": "html",
	  }
      }

 The result

 .. raw:: html

	 <iframe src="../../_static/iris.csv-pca-20221028_074618.html" height="400px" width="90%"></iframe>
