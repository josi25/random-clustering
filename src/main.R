# Main functions for the OmniBenchmark module

#' Process data using parsed command-line arguments
#'
#' @param args Parsed arguments containing:
#'   - output_dir: Output directory path
#'   - name: Module name
#'   - data_h5ad: Input files for data.h5ad (CLI: --data.h5ad)
#'   - data_clusters_truth_num: Input files for data.clusters_truth_num (CLI: --data.clusters_truth_num)
#'
#' @note Input IDs with dots (e.g., 'data.raw') are converted to underscores
#'   in R variable names (e.g., 'data_raw') but preserve dots in CLI args.
process_data <- function(args) {
  # Create output directory if needed
  dir.create(args$output_dir, recursive = TRUE, showWarnings = FALSE)
  
  raw_data <- readH5AD(args$data_h5ad[1], reader = "R")
  n_cells <- ncol(raw_data)
  cluster_count <- as.integer(readLines(args$data_clusters_truth_num[1])[1])
  cell_ids <- colnames(raw_data)
  
  set.seed(args$seed)
  
  random_clusters <- sample(
    seq_len(cluster_count),
    size = n_cells,
    replace = TRUE
  )
  
  clusters <- data.frame(
    cell_id = cell_ids,
    louvain = random_clusters,
    leiden = random_clusters
  )

  
  dataset_name <- sub("\\.h5ad$", "", basename(args$data_h5ad[1]))
  readr::write_tsv(clusters, file.path(args$output_dir, paste0(dataset_name, ".clusters.tsv")))
  
  #mock files
  # timings.json
  jsonlite::write_json(
    list(),
    file.path(args$output_dir, paste0(dataset_name, ".timings.json")),
    auto_unbox = TRUE
  )
  
  # clustering_info.json
  jsonlite::write_json(
    list(),
    file.path(args$output_dir, paste0(dataset_name, ".clustering_info.json")),
    auto_unbox = TRUE
  )
  
  # pca.tsv
  readr::write_tsv(
    data.frame(),
    file.path(args$output_dir, paste0(dataset_name, ".pca.tsv"))
  )

}
