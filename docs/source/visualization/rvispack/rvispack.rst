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

The command::
  docker run --rm venustiano/cds:rvispack-0.1.0

Will display information about the `R packages` used to implement the
visualizations. The `Index` section displays the current implemented
functions::
  Index:

  c_histogram             Histogram
  c_pcaproj               PCA projection
  c_violin                Violin plots
  validate_json_file      This function validates a json structure
  validate_parameters     Validate that a json file meets a required
                          schema

The `c_` prefix in the function name stands for containerized and
receives a JSON file. This file contains information such as the data
file, the parameters and output formats. The `name/value` pairs for
each function can be displayed by adding `<c_function_name> help` as
follows::
  docker run --rm venustiano/cds:rvispack-0.1.0 c_pcaproj help

Singularity
**********
