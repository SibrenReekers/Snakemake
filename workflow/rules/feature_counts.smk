# Rule for running featureCounts to evaluate gene expression
rule run_featurecounts:
    input:
        samples="aligned/{sample}/{sample}_aligned.bam",
        annotation=config['gtf_annotation']
    output:
        counts="counts/{sample}/{sample}.featureCounts",
        summary="counts/{sample}/{sample}.featureCounts.summary",
        jcounts="counts/{sample}/{sample}.featureCounts.jcounts"
    log:
        "logs/featurecounts/{sample}.log"
    params:
        strand="0",
        extra="-O --fracOverlap 0.2 -J -p"
    threads: config['threads_index']
    wrapper:
        "v4.1.1/bio/subread/featurecounts"
