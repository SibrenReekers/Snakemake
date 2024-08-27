# RNA-seq Data Processing Workflow

This repository contains an RNA-seq data processing workflow using Snakemake. The workflow includes steps for downloading data, running quality control, aligning reads to a reference genome, counting features, and visualizing gene expression. This pipeline has been recreated in part [RNA Sequencing of Whole Blood Defines the Signature of High Intensity Exercise at Altitude in Elite Speed Skaters](https://www.mdpi.com/2073-4425/13/4/574). The data can be found [here](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE164890)

## Repository Structure

The structure of the repository is as follows:

```sh
├── FastQC
├── config
│   └── config.yaml
├── data
├── images
│   └── dag.png
├── logs
├── slurm
│   └── config.yaml
├── sra_ids.txt
└── workflow
    ├── Snakefile
    ├── rules
    └── scripts
```


## Pipeline steps

As a quick note the pipeline takes a accesion number as input, on the current config file only two accession number are given. This is for process length purposes. In the repo you can find a file sra_ids.txt, this is a txt file with all the relevant accesion numbers that have been used in the original research.

1. Fetches paired-end FASTQ files using accession numbers from the SRA (Sequence Read Archive).
2. Runs FastQC on the downloaded FASTQ files to assess the quality of the sequencing data.
3. Downloads the reference genome and annotation files.
4. Decompresses the reference genome FASTA file.
5. Decompresses the GTF annotation file.
6. Decompresses the downloaded FASTQ files.
7. Generates the STAR index using the reference genome and GTF annotation.
8. Aligns the paired-end reads to the reference genome using STAR.
9. Runs featureCounts to evaluate gene expression by counting the number of reads aligned to each gene.
10. Visualizes gene expression data by creating a bar plot of gene expression counts.

### Packages
- `python==3.10.14`
- `conda==24.1.2`
- `matplotlib==3.7.2`
- `seaborn==0.13.2`
- `pandas==2.0.3`
- `numpy==1.24.3`

### Snakemake
This pipeline has been recreated using [Snakemake](https://snakemake.github.io/). Snakemake is a workflow management system that is mainly used in bio-informatics. With snakemake a users who isnt very familiar with python can build or rebuild analyis pipelines. The desired result and different steps will be located in the snakefile. This is the main file that refulates the output of the pipeline.

### Conda
[Conda](https://docs.conda.io/en/latest/) is a package and environment manager which makes managing a project dependencies a lot cleaner. For each project a new environment can be created in which only the required packages can be installed. This makes, for example switching between different python versions a lot easier.

The desired tools can be put in the env.yaml file and when the tool runs an environment will automaticly be created using the given packages.

## Setting Up the Workspace

1. **Create a conda virtual environment:**

    ```sh
    conda create -n snakemake_env
    ```

2. **Activate the conda virtual environment:**
   
    ```sh
    conda activate snakemake_env
    ``` 

3. **Install Snakemake:**

    ```sh
    conda install -c conda-forge -c bioconda snakemake=7.0.0
    ```

4. **Downgrade tabulate:**

    ```sh
    pip install tabulate==0.8.9
    ```

    The newest version of tabulate that comes with snakemake 7.0.0 was a bit buggy. For now downgrading to a earlier tabulate version seems to have solved the problem.
    
5. **Configure the `config.yaml` file:**

    Edit the `config/config.yaml` file to set the appropriate datapaths and parameters for your specific dataset and reference genome.
    Add extra accession numbers for a more expanded run

## Running the Workflow
To execute the workflow, run the following command:

```sh
snakemake -c <number_of_cores> --use-conda --conda-frontend conda
```
## Graphical view of the pipeline
![Workflow DAG](dag.png)

## Example output
Because of how timeconsuming this pipeline can be it is currently set up to use one sample. Other samples that have been used in the original project are located in the sra_ids.txt file. When you want to run the pipeline with multiple samples these have to be added in the config.yaml file under accession.

```sh
accession: 
  - SRR13442908
  - Other IDs...
```

![Gene expression barplot](plots/gene_expression_barplot.png)

## Troubleshooting

The main problem that can occur is outdated wrapper version. After sometime not only snakemake will be updated but also the different wrappers that have been used. The used wrapper version has to be compatible with the used snakemake version!

In case of any other erros please contact:
- Sibren Reekers
- [email](mailto:sibrenreekers@gmail.com)
- [github](https://github.com/SibrenReekers)




