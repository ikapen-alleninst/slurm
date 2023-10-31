#!/bin/bash

## To run mapping for all references against query .h5ads.

## Reference data to map labels.
CONSENSUS_M1=("/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/M1/BICCN/References/RNASeq_CrossAreal/human-M1-reference.h5ad" \
              "/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/M1/BICCN/References/RNASeq_CrossAreal/mouse-M1-reference.h5ad" \
              "/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/M1/BICCN/References/RNASeq_CrossAreal/marmoset-M1-reference.h5ad")

## Load count data
file_path_a1="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/cross_areal/references/region/clean/A1_clean.h5ad"
file_path_acc="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/cross_areal/references/region/clean/ACC_clean.h5ad"
file_path_ang="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/cross_areal/references/region/clean/ANG_clean.h5ad"
file_path_dlpfc="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/cross_areal/references/region/clean/DLPFC_clean.h5ad"
file_path_m1="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/cross_areal/references/region/clean/M1_clean.h5ad"
file_path_mtg="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/cross_areal/references/region/clean/MTG_clean.h5ad"
file_path_s1="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/cross_areal/references/region/clean/S1_clean.h5ad"
file_path_v1="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/cross_areal/references/region/clean/V1_clean.h5ad"

# cluster variable name in the annotations
cluster_name="WithinArea_cluster"

# name of the taxonomy file
taxonomy_name_a1="CrossAreal_A1"
taxonomy_name_acc="CrossAreal_ACC"
taxonomy_name_ang="CrossAreal_ANG"
taxonomy_name_dlpfc="CrossAreal_DLPFC"
taxonomy_name_m1="CrossAreal_M1"
taxonomy_name_mtg="CrossAreal_MTG"
taxonomy_name_s1="CrossAreal_S1"
taxonomy_name_v1="CrossAreal_V1"

## Specify which taxonomies to map against.
taxonomy_dir_a1="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/CrossAreal_A1"
taxonomy_dir_acc="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/CrossAreal_ACC"
taxonomy_dir_ang="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/CrossAreal_ANG"
taxonomy_dir_dlpfc="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/CrossAreal_DLPFC"
taxonomy_dir_m1="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/CrossAreal_M1"
taxonomy_dir_mtg="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/CrossAreal_MTG"
taxonomy_dir_s1="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/CrossAreal_S1"
taxonomy_dir_v1="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/CrossAreal_V1"

# save mapping results
result_dir_a1="/home/inkar.kapen/taxonomy_mapping_results/crossareal_a1_mapping_anno.rda"
result_dir_acc="/home/inkar.kapen/taxonomy_mapping_results/crossareal_acc_mapping_anno.rda"
result_dir_ang="/home/inkar.kapen/taxonomy_mapping_results/crossareal_ang_mapping_anno.rda"
result_dir_dlpfc="/home/inkar.kapen/taxonomy_mapping_results/crossareal_dlpfc_mapping_anno.rda"
result_dir_m1="/home/inkar.kapen/taxonomy_mapping_results/crossareal_m1_mapping_anno.rda"
result_dir_mtg="/home/inkar.kapen/taxonomy_mapping_results/crossareal_mtg_mapping_anno.rda"
result_dir_s1="/home/inkar.kapen/taxonomy_mapping_results/crossareal_s1_mapping_anno.rda"
result_dir_v1="/home/inkar.kapen/taxonomy_mapping_results/crossareal_v1_mapping_anno.rda"


# Define arrays for variables specific to each call
mapping_file_paths=("$file_path_a1" "$file_path_acc" "$file_path_ang" "$file_path_dlpfc" \
                    "$file_path_m1" "$file_path_mtg" "$file_path_s1" "$file_path_v1")
taxonomy_names=("$taxonomy_name_a1" "$taxonomy_name_acc" "$taxonomy_name_ang" "$taxonomy_name_dlpfc" \
                "$taxonomy_name_m1" "$taxonomy_name_mtg" "$taxonomy_name_s1" "$taxonomy_name_v1")
taxonomy_dirs=("$taxonomy_dir_a1" "$taxonomy_dir_acc" "$taxonomy_dir_ang" "$taxonomy_dir_dlpfc" \
               "$taxonomy_dir_m1" "$taxonomy_dir_mtg" "$taxonomy_dir_s1" "$taxonomy_dir_v1")
result_dirs=("$result_dir_a1" "$result_dir_acc" "$result_dir_ang" "$result_dir_dlpfc" "$result_dir_m1" \
             "$result_dir_mtg" "$result_dir_s1" "$result_dir_v1")


## 
for ((index=1; index<${#mapping_file_paths[@]}; index++)); do
    echo $index
    sbatch /home/inkar.kapen/scripts/R/taxonomy/slurm/map_crossareal.slurm "${mapping_file_paths[index]}" $cluster_name "${taxonomy_names[index]}" "${taxonomy_dirs[index]}" "${result_dirs[index]}"
done
wait
