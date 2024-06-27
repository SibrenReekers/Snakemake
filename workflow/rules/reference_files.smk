# Rule for downloading the reference genome and annotation
rule download_ref_files:
    output:
        fasta=config['genome_fasta_gz'],
        gtf=config['gtf_annotation_gz']
    log:
        "logs/download_ref_files.log"
    conda:
        "workflow/envs/env.yaml"
    shell:
        """
        curl -o {output.fasta} {config[genome_fasta_url]} > {log} 2>&1
        curl -o {output.gtf} {config[gtf_annotation_url]} >> {log} 2>&1
        """

# Rule for decompressing the reference genome FASTA file
rule decompress_genome_fasta:
    input:
        config['genome_fasta_gz']
    output:
        config['genome_fasta']
    conda:
        "workflow/envs/env.yaml"
    shell:
        "gunzip -c {input} > {output}"

# Rule for decompressing the GTF annotation file
rule decompress_gtf_annotation:
    input:
        config['gtf_annotation_gz']
    output:
        config['gtf_annotation']
    conda:
        "workflow/envs/env.yaml"
    shell:
        "gunzip -c {input} > {output}"
