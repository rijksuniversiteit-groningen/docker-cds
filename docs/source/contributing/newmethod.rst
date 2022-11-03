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
* The parameters of the method/function must be derived from a JSON
  object.
* A JSON schema must be defined to validate the JSON parameters. This
  will facilitate the creation of `JSON forms
  <https://jsonform.github.io/jsonform/playground/index.html>`_. Eventually,
  these JSON forms will be used to run containers trigered from a web
  graphical user interface.
* Unit tests
      

Create a Docker image
+++++++++++++++++++++

Conventions
-----------

* The command to run a container should include the ``--rm`` flag.
* Running the container without arguments should display the available
  functions/methods in the image.

Image tests
-----------
Document your method
++++++++++++++++++++
