New Data Science Method
=======================

.. note::

   This documentation section is under active development.


The RUG Docker-CDS methods are designed to run from a command line
interface (CLI) and from a web graphical user interface (GUI). To
achieve this, we use `JSON objects
<https://www.json.org/json-en.html>`_ and `JSON schemas
<https://json-schema.org/understanding-json-schema/>`_. In the JSON
objects three main kinds of name/value pairs should be defined,
``input data``, ``method's parameters`` and ``output specification
format``. The JSON schema is mainly used to validate the JSON object
and eventually will be used to generate a `JSON form
<https://jsonform.github.io/jsonform/playground/index.html>`_ to
collect inputs.

The containerization of data science methods will follow a
hierarchical structure. Currently, two categories have been defined
``Visualization Techniques`` and ``Containerized papers``. New
categories can be added as needed. New methods will be included in an
appropriate `branch` of the hierarchical tree or in a new category if
necessary.

Implement your method
+++++++++++++++++++++

* RUG Docker-CDS methods can be implemented in any `free` programming
  language. To develop your method you can use a pre-built Docker
  Image from `gcc <https://hub.docker.com/_/gcc>`_ , `OpenJDK
  <https://hub.docker.com/_/openjdk>`_ , `rocker
  <https://hub.docker.com/u/rocker>`_, `Jupyter Project
  <https://hub.docker.com/u/jupyter>`_ or you can build your own
  Docker image.
* Document your method. In R you could create an `R-package
  <https://r-pkgs.org/>`_ and use `roxigen2
  <https://cran.r-project.org/web/packages/roxygen2/vignettes/roxygen2.html>`_. In
  Python you could use `Sphinx
  <https://www.sphinx-doc.org/en/master/>`_. What is important is that
  commands/functions such as ``?`` or ``help`` could be used to
  display documentation.
* Prepare a command to call your method from the CLI. The command
  could be implemented as an executable binary, R or Python script. In
  Python you could use the `argparse Python package
  <https://docs.python.org/3/library/argparse.html>`_ or in R you can
  use `argparse R package
  <https://cran.r-project.org/package=argparse>`_. It is a good idea
  to follow standards for command line interfaces according to `GNU
  <https://www.gnu.org/prep/standards/standards.html#Command_002dLine-Interfaces>`_.

Calling from CLI and GUI
++++++++++++++++++++++++

Prepare your method to be called from a command line interface (CLI)
and from a web graphical user interface (GUI).

* The parameters of the method/function should be derived from a `JSON object
  <https://www.json.org/json-en.html>`_.
* A `JSON schema
  <https://json-schema.org/understanding-json-schema/>`_ must be
  defined to validate the JSON parameters. This will facilitate the
  creation of `JSON forms
  <https://jsonform.github.io/jsonform/playground/index.html>`_. Eventually,
  these JSON forms will be used to collect parameters, to run
  containerized methods, from a web graphical user interface.
* Create appropriate unit tests.

Examples of implemented methods can be found in the `rvispack
<https://github.com/rijksuniversiteit-groningen/rvispack>`_ package.
      

Create a Docker image
+++++++++++++++++++++

Conventions
-----------

* The command to run a container should include the ``--rm`` flag.
* Running the container without arguments should display the available
  functions/methods in the image.

Image tests
-----------
