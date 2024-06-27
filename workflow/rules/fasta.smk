# Rule for fetching FASTQ files using accession numbers
rule get_fastq_pe_gz:
    output:
        fwd="data/pe/{accession}_1.fastq.gz",
        rev="data/pe/{accession}_2.fastq.gz"
    log:
        "logs/pe/{accession}.gz.log"
    params:
        extra="--skip-technical"
    threads: 30
    conda:
        "/envs/env.yaml"
    wrapper:
        "v3.5.3/bio/sra-tools/fasterq-dump"

# Rule for running FastQC on the downloaded FASTQ files
rule run_fastqc:
    input:
        "data/pe/{sample}_{read}.fastq.gz"
    output:
        html="FastQC/{sample}_{read}_fastqc.html",
        zip="FastQC/{sample}_{read}_fastqc.zip"
    log:
        "logs/fastqc/{sample}_{read}_fastqc.log"
    threads: 6
    resources:
        mem_mb=1024
    conda:
        "/envs/env.yaml"
    wrapper:
        "v3.5.3/bio/fastqc"
