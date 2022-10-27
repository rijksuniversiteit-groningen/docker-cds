# Docker-CDS
Docker-CDS are a set of containerized data science methods. The
containers are designed to run as black boxes executed from a command
line interface. The input is defined in a
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

This command pulls the `venustiano/cds:rvispack-0.1.0` image from
Docker Hub in case it is not present on the local host. Then, it
displays information about the containerized package and the available
visualization techniques. Finally, it removes the stopped container
(using the `--rm` flag).

```bash
docker run --rm venustiano/cds:rvispack-0.1.0
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

Store the JSON object in a `violin_params.json` file.

```json
{
	"filename": "iris.csv",
	"y_variable": "sepal_length"
}
```


#### Creating the visualization under Linux or MacOS

```bash
docker run --rm -v "$PWD":/app/data venustiano/cds:rvispack-0.1.0 c_violin violin_params.json
```

#### Creating the visualization using Windows powershell
```bash
docker run --rm -v ${PWD}:/app/data venustiano/cds:rvispack-0.1.0 c_violin violin_params.json
```

will produce a violin plot in the `Rplots.pdf` file.


![Violin plot](https://github.com/rijksuniversiteit-groningen/docker-cds/raw/master/docs/source/_static/Rplots.pdf.png)

The `-v` flag mounts the current working directory (`$PWD`) as
`/app/data` folder in the container and `c_violin` is the function
name as displayed by the first command.

### Another example

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

#### Download the data and the JSON object

```bash
wget https://raw.githubusercontent.com/rijksuniversiteit-groningen/rvispack/master/tests/testthat/data/ggplotmpg.csv
wget https://raw.githubusercontent.com/rijksuniversiteit-groningen/rvispack/master/tests/testthat/params/mpg_params.json
```

#### Create the visualization

```bash
docker run --rm -v "$PWD":/app/data venustiano/cds:rvispack-0.1.0 c_violin mpg_params.json
```

![MPG violin plots](https://github.com/rijksuniversiteit-groningen/docker-cds/raw/master/docs/source/_static/ggplotmpg.csv-violin-20221009_203930.png)


### Using singularity

```bash
singularity build pcr.sif docker://venustiano/cds:rvispack-0.1.0
./pcr.sif
./pcr.sif c_violin mpg_params.json
```

## Contributing
