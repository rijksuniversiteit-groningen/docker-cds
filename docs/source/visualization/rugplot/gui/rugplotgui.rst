
rugplot: GUI
============

The ``rugplot`` GUI is a set of forms to facilitate a user friendly
interface to create reproducible visualization using the `rugplot
<https://github.com/rijksuniversiteit-groningen/rugplot>`_ R
package. Each of these forms display fields according to the
associated visualization technique. Based on the concept of ``The
Grammar of Graphics``, these fields can represent elements such as
``Aesthetics``, ``Attributes`` or ``Facets``.

``Aesthetics``, always represent categorical or numeric variables
meaning that a column name must be provided for this fields.

``Attributes``, always represent constant values such as numbers or
strings. Numbers can represent point size or angles and strings can
represent labels.

``Facets``, always are represented by a categorical variable (column name).

.. toctree::
   :maxdepth: 2
   :caption: Visualization techniques:

   histograms
   pca
   scatter
   violin
   heatmaps

