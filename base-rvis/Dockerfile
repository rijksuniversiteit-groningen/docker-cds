# Copyright (c) University of Groningen Data Science Team
# Distributed under the terms of the Apache License 2.0 

FROM r-base:4.2.2

LABEL maintainer="CDS Project"

ENV CRAN_URL "http://cran.rstudio.com"

RUN apt-get update && \
    apt-get install -y  build-essential \
    libcurl4-gnutls-dev \
    libfontconfig1-dev \
    freetype2-demos \
    libgit2-dev \
    dirmngr \
    libnode-dev \
    libzmq3-dev \
    libgmp3-dev \
    libmpfr-dev \
    libpng-dev \
    libjpeg-dev \
    libtiff-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libxml2-dev \
    pandoc \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/* \
    && wget -qO- \
      "https://yihui.org/tinytex/install-unx.sh" | \
      sh -s - --admin --no-path \
    && mv ~/.TinyTeX /opt/TinyTeX \
    && /opt/TinyTeX/bin/*/tlmgr path add \
    && tlmgr install metafont mfware inconsolata tex ae parskip listings pgf preview grfext \
    && tlmgr path add \
    && chown -R root:staff /opt/TinyTeX \
    && chmod -R g+w /opt/TinyTeX \
    && chmod -R g+wx /opt/TinyTeX/bin 
	

# install R and customed R packages
RUN R -e "install.packages('devtools', repos='${CRAN_URL}');"
RUN R -e "library(devtools); \
 install_version( package = 'data.table', repos='${CRAN_URL}'); \
 install_version( package = 'ggplot2', repos='${CRAN_URL}'); \
 install_version( package = 'dplyr',  repos='${CRAN_URL}'); \
 install_version( package = 'jsonlite', repos='${CRAN_URL}'); \
 install_version( package = 'ggfortify', repos='${CRAN_URL}'); \
 install_version( package = 'htmlwidgets', repos='${CRAN_URL}'); \
 install_version( package = 'tikzDevice', repos='${CRAN_URL}'); \
 install_version( package = 'tinytex', repos='${CRAN_URL}'); \
 install_version( package = 'jsonvalidate', repos='${CRAN_URL}');"

RUN R -e 'devtools::install_github("ropensci/plotly")'
