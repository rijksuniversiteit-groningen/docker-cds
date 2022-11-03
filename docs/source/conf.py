# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

project = 'docker-cds'
copyright = '2022, University of Groningen'
author = 'University of Groningen'
release = '0.0.0'

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration

extensions = []

templates_path = ['_templates']
exclude_patterns = []



# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

# html_theme = 'alabaster'
html_static_path = ['_static']

html_theme = "sphinx_book_theme"
html_title = "Docker-CDS documentation"
html_logo = "_static/twitter_icon_300px_wit.jpg"
html_theme_options = {
    "path_to_docs": "docs",
    "repository_url": "https://github.com/rijksuniversiteit-groningen/docker-cds",
    "repository_branch": "main",
    "use_edit_page_button": True,
    "use_issues_button": True,
    "use_repository_button": True,
    "use_download_button": True,
}

extensions = ["myst_parser",
              "sphinx_copybutton",'sphinx.ext.todo','sphinxcontrib.bibtex']
bibtex_bibfiles = ['refs.bib']
source_suffix = {
    ".rst": "restructuredtext",
    ".md": "markdown",
}
pygments_style = "sphinx"

# Display todos by setting to True
todo_include_todos = True
