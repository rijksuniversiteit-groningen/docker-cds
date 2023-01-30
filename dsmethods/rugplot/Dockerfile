# Copyright (c) University of Groningen Data Science Team
# Distributed under the terms of the Apache License 2.0

FROM venustiano/base-rvis:rbase-4.2.2

LABEL maintainer="CDS Project"

RUN R -e "devtools::install_github('rijksuniversiteit-groningen/cds-utils',subdir='rugutils'); \
    devtools::install_github('rijksuniversiteit-groningen/rugplot');"
RUN R -e "library(devtools); \
    install_version( package = 'argparse');"

COPY rugplots.R /app/bin/
WORKDIR /app/data/

ENTRYPOINT ["Rscript","/app/bin/rugplots.R"]
CMD []

# docker build --no-cache -t venustiano/rugplot:0.1.0 .
# docker tag rvispack:latest venustiano/rugplot
# docker push venustiano/rugplot:0.1.0
