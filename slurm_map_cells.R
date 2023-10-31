## Load scrattch.taxonomy
library(scrattch.mapping)

# Retrieve the input variables from the command line
args <- commandArgs(trailingOnly = TRUE)
mapping_file_path <- args[1]
cluster_var <- args[2]
taxonomy_name <- args[3]
taxonomy_dir <- args[4]
result_dir <- args[5]

process_data <- function(mapping_file_path, cluster_var, taxonomy_name, taxonomy_dir, result_dir){
    print("===============================================================================")
    print("============================Processing new taxonomy============================")
    print(paste("Mapping file:", mapping_file_path))
    print(paste("Cluster variable is", cluster_var))
    print(paste("Taxonomy name is", taxonomy_name))
    print(paste("Taxonomy directory is", taxonomy_dir))
    print(paste("Saving mapping results to", result_dir))

    ## Load count data  
    print(paste("============ Loading mapping data for ",  taxonomy_name, "============"))
    adata <- read_h5ad(mapping_file_path)

    ## Compute log CPM
    print(paste("============ Computing log CPM ",  taxonomy_name, "============"))
    query.data = adata$X
    query.data = t(query.data)
    query.data = logCPM(query.data)

    ## Load the shiny taxonomy into a standard object for mapping.
    print(paste("============ Loading taxonomy for ",  taxonomy_name, "============"))
    AIT.anndata = loadTaxonomy(taxonomyDir = taxonomy_dir, anndata_file=paste0(taxonomy_name, ".h5ad"))
    
    # Recompute the dendrogram
    print(paste("============ Computing dendrogram for ",  taxonomy_name, "============"))
    AIT.anndata = addDendrogramMarkers(AIT.anndata = AIT.anndata)

    ## Map! Returns a data.frame with mapping results.
    print(paste("============ Performing the taxonomy mapping for ",  taxonomy_name, "============"))
    mapping.anno = taxonomy_mapping(AIT.anndata=AIT.anndata,
                                query.data=query.data, 
                                label.cols=paste0(cluster_var, "_label"), ## Which obs in AIT.anndata contain annotations to map. E.g. "class", "subclass", etc.
                                corr.map=TRUE, 
                                tree.map=TRUE, 
                                seurat.map=FALSE)

    print(paste("============ Saving final mapping results for ",  taxonomy_name, "============"))
    save(mapping.anno, file=result_dir)
}

tryCatch({
    process_data(mapping_file_path, cluster_var, taxonomy_name, taxonomy_dir, result_dir)
    print(paste("SUCCESS MAPPING", taxonomy_name))
}, error = function(e) {
    print(paste("Error:", conditionMessage(e), "\n"))
    print(paste("ERROR in", taxonomy_name))
})
