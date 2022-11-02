# Copyright (c) University of Groningen Data Science Team
# Distributed under the terms of the Apache License 2.0

FROM venustiano/base-rvis:rbase-4.2.1

LABEL maintainer="CDS Project"

RUN R -e "devtools::install_github('rijksuniversiteit-groningen/cds-utils',subdir='rutils'); \
    devtools::install_github('rijksuniversiteit-groningen/rvispack');"

COPY cm_plots.R /app/bin/
WORKDIR /app/data/

ENTRYPOINT ["Rscript","/app/bin/cm_plots.R"]
CMD []

# docker build --no-cache -t rvispack .
# docker tag rvispack:latest venustiano/cds:rvispack-0.1.0
# docker push venustiano/cds:rvispack-0.1.0
