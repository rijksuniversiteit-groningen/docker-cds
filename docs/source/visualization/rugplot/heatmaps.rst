rugplot: Heatmaps
=================

A heatmap is typically a rectangular tiling of a color-shaded data
matrix. Additionally, this technique is one of the most
space-efficient ways to visualize data. Here some examples are given
to show how to create heatmaps using the ``rugplot`` container. The
exergaming dataset from :cite:t:`Soancatl-Aguilar2017`) will be used
to create such examples. The dataset can be downloaded by running the
following command

.. tabs::

   .. tab:: Linux

	    .. code-block:: console

			    wget https://raw.githubusercontent.com/rijksuniversiteit-groningen/rugplot/master/tests/testthat/data/exergamelf2.csv

   .. tab:: PowerShell

	    .. code-block:: powershell

	       Invoke-WebRequest https://raw.githubusercontent.com/rijksuniversiteit-groningen/rugplot/master/tests/testthat/data/exergamelf2.csv -OutFile exergamelf2.csv

			    
or by adding the link in the previous command to the JSON template that will
be created in the second step to create the heatmap.

Creating a heatmap using the ``rugplot`` container
*******************************************************

For simplicity it is better to create an ``alias``, see the
:ref:`docker-lab` section.

#. Step 1, create a `rugplot` histogram template

   .. tabs::

      .. tab:: alias

	 .. code-block:: console

	    rugplot template -p heatmap

      .. tab:: raw command
   
	 .. code-block:: console

	    docker run --rm -v "$PWD":/app/data -u $(id -u):$(id -g) venustiano/rugplot:0.1.0 \
	    template -p heatmap

      .. tab:: PowerShell
   
	 .. code-block:: powershell

	    docker run --rm -v ${PWD}:/app/data venustiano/rugplot:0.1.0 `
	    template -p heatmap

   A ``heatmap_params.json`` file will be created including some of
   the `name/value` pairs listed below:

   .. code-block:: json

      {
          "description": "Parameters to create a heatmap plot using the 'rugplot' R package",
	  "filename": "<filename path>",
	  "method": "raster",
	  "aesthetics": {
              "y_variable": "<Y required column name>",
              "x_variable": "<X required column name>",
              "fill": "<required variable>",
	  },
      }

#. Step 2, adding ``'data file'``, ``'x, y and fill
   variables'``, and some ``save`` properties:

   .. code-block:: json

      {
	  "filename": "exergamelf2.csv",
	  "aesthetics": {
	      "y_variable": "myVars",
              "x_variable": "idrow",
	      "fill": "normVal",
          },
	  "save": {
              "save": true,
              "outputfilename": "exergaming_heatmap",
              "width": 17,
              "height": 7,
              "dpi": 300,
              "device": "png",
	  }	  
      }

#. Step 3, create the heatmap

   .. tabs::

      .. tab:: alias

	 .. code-block:: console

	    rugplot plot -p heatmap --file heatmap_params.json

      .. tab:: raw command
	       
	 .. code-block:: console

	    docker run --rm -v "$PWD":/app/data -u $(id -u):$(id -g) venustiano/rugplot:0.1.0 \
            plot -p heatmap --file heatmap_params.json

      .. tab:: PowerShell
	       
	 .. code-block:: powershell

	    docker run --rm -v ${PWD}:/app/data venustiano/rugplot:0.1.0 `
            plot -p heatmap --file heatmap_params.json

   The result will be stored in the ``exergamin_heatmap.png`` file.

   .. figure:: ../../_static/exergaming_heatmap.png
	       :height: 250
	       :alt: heatmap

#. Step 4, customizing color, label and LaTeX format

   .. code-block:: json

      {
        "labels": {
            "x": "Trials per participant",
	    "y": "Balance measures",
	    "fill": "Normalized\nmeasures",
	},
	"colour_scales": {
	    "fill_gradient": {
                "method": "gradient",
		"low": "#fee0d2",
		"high": "#67000d",
	     }
	},
	"axes_scales": {
            "y_discrete": {
                "labels": ["medTIms51 = I`", "medTI51 = I",
		"medSpeed = Speed", "medLsdD51 = SD`",
		"medLsd51 = SD", "medLrmslD51 = RMS`",
		"medLrms51 = RMS", "medLcovD51 = CoV`",
		"medLcov51 = CoV", "medK = $\\\\kappa$",
		"meanK = $\\\\overline{\\\\kappa}$"]
            }
	},
	"save": {
            "device": "tikz",
	    "sanitize": false
	}
      }
		   
   .. figure:: ../../_static/exergaming_heatmap_tikz-1.png
	       :height: 250
	       :alt: heatmaptikz
   
   
References
**********

.. bibliography::
   :filter: docname in docnames
