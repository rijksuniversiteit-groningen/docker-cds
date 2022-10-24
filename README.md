# Docker-CDS
Docker-CDS are a set of containerized data science methods.

## Quick Start

To run the examples below you need to have [Docker
installed](https://docs.docker.com/get-docker/).

### Visualization techniques

This command pulls the `venustiano/cds:rvispack-0.1.0` image from
Docker Hub in case it is not present on the local host. Then, it
displays information about the containerized package and the available
visualization techniques. Finally, it removes the stopped container.

```bash
docker run --rm venustiano/cds:rvispack-0.1.0
```

To create visualizations using this image, you need a tabular data
file and a JSON object stored in the current working directory. The
supported file formats are defined by
[`fread`](https://rdrr.io/cran/data.table/man/fread.html) function
implemented in the `R data.table` package

**Violin plots:**

