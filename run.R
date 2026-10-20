#!/usr/bin/env Rscript

library(argparse)

# Source main functions
source("src/main.R")

# Parse command line arguments
parser <- ArgumentParser(description="OmniBenchmark module")

# Required by OmniBenchmark
parser$add_argument("--output_dir", dest="output_dir", type="character", required=TRUE,
                   help="Output directory for results")
parser$add_argument("--name", dest="name", type="character", required=TRUE,
                   help="Module name/identifier")
# Stage-specific inputs
parser$add_argument("--data.h5ad", dest="data_h5ad",
                   type="character", nargs="+", required=TRUE,
                   help="Input: data.h5ad")
parser$add_argument("--data.clusters_truth_num", dest="data_clusters_truth_num",
                   type="character", nargs="+", required=TRUE,
                   help="Input: data.clusters_truth_num")

args <- parser$parse_args()

cat("Output directory:", args$output_dir, "\n")
cat("Module name:", args$name, "\n")
cat("data.h5ad:", args$data_h5ad, "\n")
cat("data.clusters_truth_num:", args$data_clusters_truth_num, "\n")

# TODO: Implement your module logic
# Process the data using main function
process_data(args)
