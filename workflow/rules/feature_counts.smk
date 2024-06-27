# rules/feature_counts.smk

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
        strand="0",  # Adjust based on your library: '0' (unstranded), '1' (stranded), '2' (reverse stranded)
        extra="-O --fracOverlap 0.2 -J -p"  # Additional parameters: -O (count multi-overlapping reads), -J (output read counts per junction)
    threads: 4
    wrapper:
        "v3.13.1/bio/subread/featurecounts"
