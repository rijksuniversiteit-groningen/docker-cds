Nextflow
========

`Nextflow <https://www.nextflow.io/about-us.html>`_ is a free and
open-source software used to write, deploy and share data-intensive,
highly scalable, workflows on any infrastructure.

Compatibility
*************

Our containerized methods are compatible with the Nextflow Domain
Specific Language (DSL). It is possible to integrate the Containerized
Data Science (CDS) CLI commands in Nexflow scripts, if the JSON
parameters and data are available. For example, to run the histogram
examples in :doc:`../visualization/rugplot/histograms`, a Nexflow
script should be written as follows:

.. code-block:: java

   process rugplotviz {
     output:
       stdout
    
     """
     echo $PWD
     docker run --rm -v "$PWD":/app/data -u \$(id -u):\$(id -g) venustiano/rugplot:0.1.0 \
     plot -p histogram --file histogram_params.json
     """
   }

   workflow {
     rugplotviz | view { it.trim() }
   }

Note that the latter two ``$`` in the docker command are escaped. See
the Nextflow `documentation
<https://www.nextflow.io/docs/latest/process.html#>`_ for further
details.
