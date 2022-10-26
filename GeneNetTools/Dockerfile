# Copyright (c) University of Groningen Data Science Team
# Distributed under the terms of the Apache License 2.0

FROM venustiano/base-rvis:rbase-4.2.1

LABEL maintainer="CDS Project"

RUN apt-get update && \
    apt-get install -y \
    libglpk-dev \
        && rm -rf /var/lib/apt/lists/*

RUN R -e " devtools::install_github('V-Bernal/GeneNetTools@venus/feature/container', subdir = 'GeneNetTools'); \
    install.packages('igraph');"

COPY c_gene.R /app/bin/
WORKDIR /app/data/

ENTRYPOINT ["Rscript","/app/bin/c_gene.R"]
CMD []

# docker build --no-cache -t genenettools .
# docker tag rvispack:latest venustiano/cds:genenettools-0.1.0
# docker push venustiano/cds:genenettools-0.1.0
