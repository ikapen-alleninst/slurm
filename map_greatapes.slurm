#!/bin/bash
#SBATCH --job-name=mapping_cells_job    # Job name
#SBATCH --mail-type=END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=inkar.kapen@alleninstitute.org     # Where to send mail  
#SBATCH --ntasks=2                    # Run on a single CPU
#SBATCH --mem=256gb                     # Job memory request (per node)
#SBATCH --time=12:00:00               # Time limit hrs:min:sec
#SBATCH --output=mapping_cells_job_%j.log   # Standard output and error log
#SBATCH --partition celltypes         # Partition used for processing
#SBATCH --tmp=20G                     # Request the amount of space your jobs needs on /scratch/fast
 
pwd; hostname; date
 
# Path to the R script
r_script="/home/inkar.kapen/scripts/R/taxonomy/slurm_map_cells.R"

# Number of calls
calls=2

## Load mapping data
file_path_human="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/great_apes/species/great_apes_human_with_meta.h5ad"
#file_path_gorilla="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/great_apes/species/great_apes_gorilla_with_meta.h5ad"
file_path_chimp="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/great_apes/species/great_apes_chimp_with_meta.h5ad"
#file_path_macaque="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/great_apes/species/great_apes_rhesus_with_meta.h5ad"
#file_path_marmoset="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/great_apes/species/great_apes_marmoset_with_meta.h5ad"

# cluster variable name in the annotations
cluster_name="cross_species_cluster"

# name of the taxonomy file
taxonomy_name_human="GreatApes_Human"
#taxonomy_name_gorilla="GreatApes_Gorilla"
taxonomy_name_chimp="GreatApes_Chimp"
#taxonomy_name_macaque="GreatApes_Macaque"
#taxonomy_name_marmoset="GreatApes_Marmoset"

## Specify which taxonomies to map against.
taxonomy_dir_human="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/GreatApes_Human"
#taxonomy_dir_gorilla="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/GreatApes_Gorilla"
taxonomy_dir_chimp="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/GreatApes_Chimp"
#taxonomy_dir_macaque="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/GreatApes_Macaque"
#taxonomy_dir_marmoset="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/GreatApes_Marmoset"

# save mapping results
result_dir_human="/home/inkar.kapen/taxonomy_mapping_results/greatapes_human_mapping_anno.rda"
#result_dir_gorilla="/home/inkar.kapen/taxonomy_mapping_results/greatapes_gorilla_mapping_anno.rda"
result_dir_chimp="/home/inkar.kapen/taxonomy_mapping_results/greatapes_chimp_mapping_anno.rda"
#result_dir_macaque="/home/inkar.kapen/taxonomy_mapping_results/greatapes_macaque_mapping_anno.rda"
#result_dir_marmoset="/home/inkar.kapen/taxonomy_mapping_results/greatapes_marmoset_mapping_anno.rda"

# Define arrays for variables specific to each call
declare -a mapping_file_paths=("$file_path_human" "$file_path_chimp")
declare -a taxonomy_names=("$taxonomy_name_human" "$taxonomy_name_chimp")
declare -a taxonomy_dirs=("$taxonomy_dir_human" "$taxonomy_dir_chimp")
declare -a result_dirs=("$result_dir_human" "$result_dir_chimp")


# Loop through the calls
for ((call=0; call<$calls; call++)); do
    echo "Call $((call+1))"

    # Extract variables specific to this call
    mapping_file_path="${mapping_file_paths[$call]}"
    taxonomy_name="${taxonomy_names[$call]}"
    taxonomy_dir="${taxonomy_dirs[$call]}"
    result_dir="${result_dirs[$call]}"
    
    # Call the R script with the variables
    echo "Running a python script on a single thread"
    singularity exec --cleanenv docker://njjai/scrattch_mapping:0.5 Rscript "$r_script" "$mapping_file_path" "$cluster_name" "$taxonomy_name" "$taxonomy_dir" "$result_dir" &
    echo "Finished running a python script on a single thread"
    date
done
wait
