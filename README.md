# RUG Docker-CDS

![GitHub](https://img.shields.io/github/license/rijksuniversiteit-groningen/docker-cds)
![Read the Docs](https://img.shields.io/readthedocs/docker-cds)
![GitHub commit activity](https://img.shields.io/github/commit-activity/m/rijksuniversiteit-groningen/docker-cds)

RUG Docker-CDS are a set of containerized data science methods. The
containers are designed to run as black boxes executed from a command
line interface. The input of a method is defined in a
[JSON](https://www.json.org/json-en.html) file including information
such as the data file, the parameters of the method and the output
formats.

The [User Guide on
ReadTheDocs](https://docker-cds.readthedocs.io/en/latest/index.html)
provides the latest documentation of the containerized data science
methods.

## Quick Start

To run the examples below you need to have [Docker
installed](https://docs.docker.com/get-docker/).

### Visualization techniques

This command pulls the `venustiano/rugplot:0.1.0` image from
Docker Hub in case it is not present on the local host. Then, it
displays information about the containerized package and the available
visualization techniques. Finally, it removes the stopped container
(using the `--rm` flag).

```bash
docker run --rm venustiano/rugplot:0.1.0
```

To create visualizations using this image, you need a tabular data
file and a JSON object stored in the current working directory. The
supported file formats are defined by
[`fread`](https://rdrr.io/cran/data.table/man/fread.html) function
implemented in the `R data.table` package.

**Violin plots:**

Download the data.

```bash
wget https://raw.githubusercontent.com/rijksuniversiteit-groningen/rvispack/master/tests/testthat/data/iris.csv
```

#### 1. Create a violin JSON template

##### PowerShell


```bash
docker run --rm -v ${PWD}:/app/data venustiano/rugplot:0.1.0 `
template -p violin
```

##### Linux
```bash
docker run --rm -v "$PWD":/app/data venustiano/rugplot:0.1.0 \
template -p violin
```

#### 2. Update the following key/value pairs in the `violin_params.json` file as follows:

```json
{
	"filename": "iris.csv",
	"aesthetics": {
	    "y_variable": "sepal_length"
	}
}
```

#### Create the visualization under Linux or MacOS

```bash
docker run --rm -v "$PWD":/app/data venustiano/rugplot:0.1.0 \
plot -p violin -f violin_params.json
```

#### Creating the visualization using Windows powershell
```bash
docker run --rm -v "$PWD":/app/data venustiano/rugplot:0.1.0 `
plot -p violin -f violin_params.json
```

will produce a violin plot in the `Rplots.pdf` file.


![Violin plot](https://github.com/rijksuniversiteit-groningen/docker-cds/raw/master/docs/source/_static/Rplots.pdf.png)

The `-v` flag mounts the current working directory (`$PWD`) as
`/app/data` folder in the container, `-p violin` is the plot function
and `-f violin_params.json` is the file that contains the information
to create the violin plot.

### Another example

Create a JSON template called `mpg_params.csv`

##### PowerShell
```bash
docker run --rm -v ${PWD}:/app/data venustiano/rugplot:0.1.0 `
template -p violin -f mpg_params.json
```

##### Linux
```bash
docker run --rm -v "$PWD":/app/data venustiano/rugplot:0.1.0 \
template -p violin -f mpg_params.json
```

#### 2. Update the following key/value pairs in the `mpg_params.json` file as follows:

```json
{
    "filename": "ggplotmpg.csv",
    "y_variable": "hwy",
    "x_variable": "class",
    "colour": "class",
    "fill": "class",
    "rotxlabs": 45,
    "boxplot": {
		"addboxplot": true,
	    "width": 0.1
    },
	"save":{
	  "save": true,
	  "width": 15,
	  "height": 10,
	  "device": "png"
	}
}
```

#### Download the data

```bash
wget https://raw.githubusercontent.com/rijksuniversiteit-groningen/rvispack/master/tests/testthat/data/ggplotmpg.csv
```

#### Create the visualization

##### Linux
```bash
docker run --rm -v "$PWD":/app/data venustiano/rugplot:0.1.0 \ 
plot -p violin -f  mpg_params.json
```

##### PowerShell
```bash
docker run --rm -v ${PWD}:/app/data venustiano/rugplot:0.1.0 ` 
plot -p violin -f  mpg_params.json
```

![MPG violin
plots](https://github.com/rijksuniversiteit-groningen/docker-cds/raw/master/docs/source/_static/ggplotmpg.csv-violin-20221009_203930.png)


### Using singularity

```bash
singularity build pcr.sif docker://venustiano/rugplot:0.1.0
./pcr.sif
./pcr.sif c_violin mpg_params.json
```

## Contributing

Please see the [Contributor Guide on ReadTheDocs](https://docker-cds.readthedocs.io/en/latest/contributing/contributing.html) for information about how to contribute updates, features, tests and community maintained methods.
