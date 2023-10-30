#!/bin/bash
#SBATCH --job-name=mapping_cells_job    # Job name
#SBATCH --mail-type=END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=inkar.kapen@alleninstitute.org     # Where to send mail  
#SBATCH --ntasks=16                    # Run on a single CPU
#SBATCH --mem=256gb                     # Job memory request (per node)
#SBATCH --time=12:00:00               # Time limit hrs:min:sec
#SBATCH --output=mapping_cells_job_%j.log   # Standard output and error log
#SBATCH -e mapping_cells_job_%j.err
#SBATCH --partition celltypes         # Partition used for processing
#SBATCH --tmp=40G                     # Request the amount of space your jobs needs on /scratch/fast
 
pwd; hostname; date
 
# Path to the R script
r_script="/home/inkar.kapen/scripts/R/taxonomy/slurm_map_cells.R"

# Number of calls
calls=8

## Load count data
file_path_crossareal_a1="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/cross_areal/references/region/clean/A1_clean.h5ad"
file_path_crossareal_acc="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/cross_areal/references/region/clean/ACC_clean.h5ad"
file_path_crossareal_ang="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/cross_areal/references/region/clean/ANG_clean.h5ad"
file_path_crossareal_dlpfc="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/cross_areal/references/region/clean/DLPFC_clean.h5ad"
file_path_crossareal_m1="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/cross_areal/references/region/clean/M1_clean.h5ad"
file_path_crossareal_mtg="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/cross_areal/references/region/clean/MTG_clean.h5ad"
file_path_crossareal_s1="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/cross_areal/references/region/clean/S1_clean.h5ad"
file_path_crossareal_v1="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/cross_areal/references/region/clean/V1_clean.h5ad"

# cluster variable name in the annotations
cluster_name="WithinArea_cluster"

# name of the taxonomy file
taxonomy_name_crossareal_a1="CrossAreal_A1"
taxonomy_name_crossareal_acc="CrossAreal_ACC"
taxonomy_name_crossareal_ang="CrossAreal_ANG"
taxonomy_name_crossareal_dlpfc="CrossAreal_DLPFC"
taxonomy_name_crossareal_m1="CrossAreal_M1"
taxonomy_name_crossareal_mtg="CrossAreal_MTG"
taxonomy_name_crossareal_s1="CrossAreal_S1"
taxonomy_name_crossareal_v1="CrossAreal_V1"

## Specify which taxonomies to map against.
taxonomy_dir_crossareal_a1="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/CrossAreal_A1"
taxonomy_dir_crossareal_acc="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/CrossAreal_ACC"
taxonomy_dir_crossareal_ang="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/CrossAreal_ANG"
taxonomy_dir_crossareal_dlpfc="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/CrossAreal_DLPFC"
taxonomy_dir_crossareal_m1="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/CrossAreal_M1"
taxonomy_dir_crossareal_mtg="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/CrossAreal_MTG"
taxonomy_dir_crossareal_s1="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/CrossAreal_S1"
taxonomy_dir_crossareal_v1="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/CrossAreal_V1"

# save mapping results
result_dir_crossareal_a1="taxonomy_mapping_results/crossareal_a1_mapping_anno.rda"
result_dir_crossareal_acc="taxonomy_mapping_results/crossareal_acc_mapping_anno.rda"
result_dir_crossareal_ang="taxonomy_mapping_results/crossareal_ang_mapping_anno.rda"
result_dir_crossareal_dlpfc="taxonomy_mapping_results/crossareal_dlpfc_mapping_anno.rda"
result_dir_crossareal_m1="taxonomy_mapping_results/crossareal_m1_mapping_anno.rda"
result_dir_crossareal_mtg="taxonomy_mapping_results/crossareal_mtg_mapping_anno.rda"
result_dir_crossareal_s1="taxonomy_mapping_results/crossareal_s1_mapping_anno.rda"
result_dir_crossareal_v1="taxonomy_mapping_results/crossareal_v1_mapping_anno.rda"


# Define arrays for variables specific to each call
declare -a mapping_file_paths=("$file_path_crossareal_a1" "$file_path_crossareal_acc" "$file_path_crossareal_ang" "$file_path_crossareal_dlpfc" "$file_path_crossareal_m1" "$file_path_crossareal_mtg" "$file_path_crossareal_s1" "$file_path_crossareal_v1")
declare -a taxonomy_names=("$taxonomy_name_crossareal_a1" "$taxonomy_name_crossareal_acc" "$taxonomy_name_crossareal_ang" "$taxonomy_name_crossareal_dlpfc" "$taxonomy_name_crossareal_m1" "$taxonomy_name_crossareal_mtg" "$taxonomy_name_crossareal_s1" "$taxonomy_name_crossareal_v1")
declare -a taxonomy_dirs=("$taxonomy_dir_crossareal_a1" "$taxonomy_dir_crossareal_acc" "$taxonomy_dir_crossareal_ang" "$taxonomy_dir_crossareal_dlpfc" "$taxonomy_dir_crossareal_m1" "$taxonomy_dir_crossareal_mtg" "$taxonomy_dir_crossareal_s1" "$taxonomy_dir_crossareal_v1")
declare -a result_dirs=("$result_dir_crossareal_a1" "$result_dir_crossareal_acc" "$result_dir_crossareal_ang" "$result_dir_crossareal_dlpfc" "$result_dir_crossareal_m1" "$result_dir_crossareal_mtg" "$result_dir_crossareal_s1" "$result_dir_crossareal_v1")


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