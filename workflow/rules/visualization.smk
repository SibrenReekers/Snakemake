rule visualize_gene_expression:
    input:
        feature_counts=expand("counts/{sample}/{sample}.featureCounts", sample=config['accession'])
    output:
        plot="plots/gene_expression_barplot.png"
    conda:
        "workflow/envs/env.yaml"
    script:
        "workflow/scripts/visualize_gene_expression.py"
