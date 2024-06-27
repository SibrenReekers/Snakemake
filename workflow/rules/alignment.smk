# Rule for decompressing FASTQ files
rule decompress_fastq:
    input:
        "data/pe/{sample}_{read}.fastq.gz"
    output:
        "data/pe/{sample}_{read}.fastq"
    conda:
        "workflow/envs/env.yaml"
    shell:
        "gunzip -c {input} > {output}"

# Rule for generating the STAR index
rule generate_star_index:
    input:
        fasta=config['genome_fasta'],
        gtf=config['gtf_annotation']
    output:
        "data/refs/star_index/Genome"
    log:
        "logs/generate_star_index.log"
    threads: config['threads_index']
    conda:
        "workflow/envs/env.yaml"
    wrapper:
        "v3.5.3/bio/star/index"

# Rule for STAR alignment using the wrapper
rule star_alignment:
    input:
        fq1="data/pe/{sample}_1.fastq",
        fq2="data/pe/{sample}_2.fastq",
        idx="data/refs/star_index/Genome"
    output:
        aln="aligned/{sample}/{sample}_aligned.bam",
        log="logs/star/{sample}/Log.final.out",
        sj="aligned/{sample}/SJ.out.tab",
        unmapped=["aligned/{sample}/unmapped_1.fastq.gz","aligned/{sample}/unmapped_2.fastq.gz"],
    log:
        "logs/star_alignment/{sample}.log"
    threads: 6
    params:
        extra="--outSAMtype BAM SortedByCoordinate --quantMode TranscriptomeSAM GeneCounts"
    conda:
        "workflow/envs/env.yaml"
    wrapper:
        "v3.6.0/bio/star/align"
