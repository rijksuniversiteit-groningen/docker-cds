New Data Science Method
=======================

The containerization of data science methods will follow a
hierarchical structure. Currentely, two categories have been defined
``Visualization Techniques`` and ``Containerized papers``. New
categories can be added as needed. New methods will be included in an
appropriate `branch` of the hierarchical tree or in a new category if
necessary.

Implement your method
+++++++++++++++++++++

* Data science methods can be implemented in any `free`
  programming language.
* Document your method. In R an `R-package <https://r-pkgs.org/>`_ can
  be created and `roxigen2
  <https://cran.r-project.org/web/packages/roxygen2/vignettes/roxygen2.html>`_
  can be used to create the documentation. In Python `Sphinx
  <https://www.sphinx-doc.org/en/master/>`_ could be used to document
  the methods. What is important is that commands/functions such as
  ``?`` or ``help`` could be used to display documentation.
* The parameters of the method/function should be derived from a `JSON
  <https://www.json.org/json-en.html>`_ object.
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
