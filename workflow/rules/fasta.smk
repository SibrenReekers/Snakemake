# Rule for fetching FASTQ files using accession numbers
rule get_fastq_pe_gz:
    output:
        fwd="data/pe/{accession}_1.fastq.gz",
        rev="data/pe/{accession}_2.fastq.gz"
    log:
        "logs/pe/{accession}.gz.log"
    params:
        extra="--skip-technical"
    threads: config['threads_index']
    wrapper:
        "v4.1.1/bio/sra-tools/fasterq-dump"

# Rule for running FastQC on the downloaded FASTQ files
rule run_fastqc:
    input:
        "data/pe/{sample}_{read}.fastq.gz"
    output:
        html="FastQC/{sample}_{read}_fastqc.html",
        zip="FastQC/{sample}_{read}_fastqc.zip"
    log:
        "logs/fastqc/{sample}_{read}_fastqc.log"
    threads: config['threads_index']
    resources: config['mem_mb']
    wrapper:
        "v4.1.1/bio/fastqc"
