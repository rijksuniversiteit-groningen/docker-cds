New Reusable Data Science Method
================================

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

Implementing a new data science method
++++++++++++++++++++++++++++++++++++++

#. Chose a method.
#. Verify that the method has not been implemented yet.
#. Define a JSON schema to validate the input parameters.
#. Implement the method considering the following:

   - Develop your method directly in a Docker container such as `gcc
     <https://hub.docker.com/_/gcc>`_ , `OpenJDK
     <https://hub.docker.com/_/openjdk>`_ , `rocker
     <https://hub.docker.com/u/rocker>`_, `Jupyter Project
     <https://hub.docker.com/u/jupyter>`_ or you can build your own
     Docker image.
   - The main function receive parameters derived from a JSON
     object/file.
   - The parameters are validated using the JSON schema defined in the
     previous step.
   - Make sure you can run the method from the command line
     interface. In Python you could use the `argparse Python package
     <https://docs.python.org/3/library/argparse.html>`_ or in R you
     can use `argparse R package
     <https://cran.r-project.org/package=argparse>`_. For example, an
     ``R`` method can be executed as follows::

	Rscript method.R [options] <parameters.json>

     or using a bash-style script ``#!<path to interpreter>``
     ::
	
	method.R [options] <parameters.json>

     In fact, `method.R` can be any executable file and
     ``parameters.json`` is a required argument containing essential
     information to run the method.
   - Follow standards for command line interfaces according to `GNU
     <https://www.gnu.org/prep/standards/standards.html#Command_002dLine-Interfaces>`_.
   - Enable functions such as ``?`` or ``help`` to display
     documentation. In R you could create an `R-package
     <https://r-pkgs.org/>`_ and use `roxigen2
     <https://cran.r-project.org/web/packages/roxygen2/vignettes/roxygen2.html>`_.
     In Python you could use `Sphinx
     <https://www.sphinx-doc.org/en/master/>`_.
   - Create appropriate unit tests.
   - Identify a potential Docker image to embed the method or build a
     minimal container. In the latter case, use the command to run the
     method as ``ENTRYPOINT`` in the Dockerfile.
   - Follow `Dockerfile best practices
     <https://docs.docker.com/develop/develop-images/dockerfile_best-practices/>`_.
   - Push the docker image to Docker Hub.
     
#. Update RUG Docker-CDS documentation by adding the new method in the
   `contents` section including details and examples to run the method.


Examples of implemented methods can be found in the `rvispack
<https://github.com/rijksuniversiteit-groningen/rvispack>`_ package.
      
