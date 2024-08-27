#!/usr/bin/env python3
"""
This script creates a bar plot visualisation of the top 10 most expressed genes.
It loops through the counts file generated with the snakemake pipeline, filters out any very low gene counts
and gets the mean of the higher ones. The top ten most expressed genes will be selected and plot as a bar plot.
"""

__author__ = "Sibren Reekers"
__version__ = "1.0.0"
__date__ = "2024-aug-27"

import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np

# List of input featureCounts files (this will be passed from Snakemake)
input_files = snakemake.input.feature_counts

# Initialize an empty DataFrame to store counts
counts_df = pd.DataFrame()

# Loop through each file and read the counts
for file in input_files:
    sample_name = file.split('/')[-1].split('.')[0]
    counts = pd.read_csv(file, sep='\t', comment='#', index_col=0)
    counts = counts.iloc[:, 5]  
    counts_df[sample_name] = counts

# Filter low count genes
counts_filtered = counts_df[counts_df.sum(axis=1) > 10]

# Calculate the mean expression across all samples
mean_expression = counts_filtered.mean(axis=1)

# Select the top 10 most expressed genes
top_genes = mean_expression.nlargest(10).index

# Subset the original counts dataframe to include only the top 10 genes
top_counts = counts_filtered.loc[top_genes]

# Plot the top 10 most expressed genes as a bar plot
top_counts.sum(axis=1).plot(kind='bar')
plt.title("Top 10 Most Expressed Genes")
plt.xlabel("Genes")
plt.ylabel("Total Counts")
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig(snakemake.output.plot)

plt.show()
