# Rule for running featureCounts to evaluate gene expression
rule run_featurecounts:
    input:
        samples="aligned/{sample}/{sample}_aligned.bam",
        annotation=config['gtf_annotation']
    output:
        multiext(
            "counts/{sample}/{sample}",
            ".featureCounts",
            ".featureCounts.summary",
            ".featureCounts.jcounts"
        )
    log:
        "logs/featurecounts/{sample}.log"
    params:
        strand="0",
        extra="-O --fracOverlap 0.2 -J -p"  
    threads: config['threads_index']
    conda:
        "../envs/env.yaml"
    wrapper:
        "v3.13.1/bio/subread/featurecounts"
