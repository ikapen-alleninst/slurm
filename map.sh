#!/bin/bash

## To run mapping for all references against query .h5ads.

## Load count data
file_path_biccn_mouse="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/M1/BICCN/References/10XMultiome_BingRen/Mouse_rna.h5ad"
file_path_biccn_human="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/M1/BICCN/References/10XMultiome_BingRen/Human_rna.h5ad"
file_path_biccn_mac="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/M1/BICCN/References/10XMultiome_BingRen/Macaque_rna.h5ad"
file_path_biccn_mar="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/M1/BICCN/References/10XMultiome_BingRen/Marmoset_rna.h5ad"
file_path_greatapes_human="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/great_apes/species/great_apes_human_with_meta.h5ad"
file_path_greatapes_gorilla="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/great_apes/species/great_apes_gorilla_with_meta.h5ad"
file_path_greatapes_chimp="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/great_apes/species/great_apes_chimp_with_meta.h5ad"
file_path_greatapes_macaque="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/great_apes/species/great_apes_rhesus_with_meta.h5ad"
file_path_greatapes_marmoset="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/great_apes/species/great_apes_marmoset_with_meta.h5ad"
file_path_crossareal_a1="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/cross_areal/references/region/clean/A1_clean.h5ad"
file_path_crossareal_acc="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/cross_areal/references/region/clean/ACC_clean.h5ad"
file_path_crossareal_ang="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/cross_areal/references/region/clean/ANG_clean.h5ad"
file_path_crossareal_dlpfc="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/cross_areal/references/region/clean/DLPFC_clean.h5ad"
file_path_crossareal_m1="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/cross_areal/references/region/clean/M1_clean.h5ad"
file_path_crossareal_mtg="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/cross_areal/references/region/clean/MTG_clean.h5ad"
file_path_crossareal_s1="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/cross_areal/references/region/clean/S1_clean.h5ad"
file_path_crossareal_v1="/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/cross_areal/references/region/clean/V1_clean.h5ad"

# cluster variable name in the annotations
cluster_name_biccn="cluster_Bakken_2022"
cluster_name_greatapes="cross_species_cluster"
cluster_name_crossareal="WithinArea_cluster"

# name of the taxonomy file
taxonomy_name_biccn_mouse="BICCN_M1_Mouse"
taxonomy_name_biccn_human="BICCN_M1_Human"
taxonomy_name_biccn_mac="BICCN_M1_Macaque"
taxonomy_name_biccn_mar="BICCN_M1_Marmoset"
taxonomy_name_greatapes_human="GreatApes_Human"
taxonomy_name_greatapes_gorilla="GreatApes_Gorilla"
taxonomy_name_greatapes_chimp="GreatApes_Chimp"
taxonomy_name_greatapes_macaque="GreatApes_Macaque"
taxonomy_name_greatapes_marmoset="GreatApes_Marmoset"
taxonomy_name_crossareal_a1="CrossAreal_A1"
taxonomy_name_crossareal_acc="CrossAreal_ACC"
taxonomy_name_crossareal_ang="CrossAreal_ANG"
taxonomy_name_crossareal_dlpfc="CrossAreal_DLPFC"
taxonomy_name_crossareal_m1="CrossAreal_M1"
taxonomy_name_crossareal_mtg="CrossAreal_MTG"
taxonomy_name_crossareal_s1="CrossAreal_S1"
taxonomy_name_crossareal_v1="CrossAreal_V1"

## Specify which taxonomies to map against.
taxonomy_dir_biccn_mouse="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/BICCN_M1_Mouse"
taxonomy_dir_biccn_human="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/BICCN_M1_Human"
taxonomy_dir_biccn_mac="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/BICCN_M1_Macaque"
taxonomy_dir_biccn_mar="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/BICCN_M1_Marmoset"
taxonomy_dir_greatapes_human="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/GreatApes_Human"
taxonomy_dir_greatapes_gorilla="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/GreatApes_Gorilla"
taxonomy_dir_greatapes_chimp="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/GreatApes_Chimp"
taxonomy_dir_greatapes_macaque="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/GreatApes_Macaque"
taxonomy_dir_greatapes_marmoset="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/GreatApes_Marmoset"
taxonomy_dir_crossareal_a1="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/CrossAreal_A1"
taxonomy_dir_crossareal_acc="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/CrossAreal_ACC"
taxonomy_dir_crossareal_ang="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/CrossAreal_ANG"
taxonomy_dir_crossareal_dlpfc="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/CrossAreal_DLPFC"
taxonomy_dir_crossareal_m1="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/CrossAreal_M1"
taxonomy_dir_crossareal_mtg="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/CrossAreal_MTG"
taxonomy_dir_crossareal_s1="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/CrossAreal_S1"
taxonomy_dir_crossareal_v1="/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/10x_seq/CrossAreal_V1"


# save mapping results
result_dir_biccn_mouse="taxonomy_mapping_results/biccn_mouse_mapping_anno.rda"
result_dir_biccn_human="taxonomy_mapping_results/biccn_human_mapping_anno.rda"
result_dir_biccn_mac="taxonomy_mapping_results/biccn_macaque_mapping_anno.rda"
result_dir_biccn_mar="taxonomy_mapping_results/biccn_marmoset_mapping_anno.rda"
result_dir_greatapes_human="taxonomy_mapping_results/greatapes_human_mapping_anno.rda"
result_dir_greatapes_gorilla="taxonomy_mapping_results/greatapes_gorilla_mapping_anno.rda"
result_dir_greatapes_chimp="taxonomy_mapping_results/greatapes_chimp_mapping_anno.rda"
result_dir_greatapes_macaque="taxonomy_mapping_results/greatapes_macaque_mapping_anno.rda"
result_dir_greatapes_marmoset="taxonomy_mapping_results/greatapes_marmoset_mapping_anno.rda"
result_dir_crossareal_a1="taxonomy_mapping_results/crossareal_a1_mapping_anno.rda"
result_dir_crossareal_acc="taxonomy_mapping_results/crossareal_acc_mapping_anno.rda"
result_dir_crossareal_ang="taxonomy_mapping_results/crossareal_ang_mapping_anno.rda"
result_dir_crossareal_dlpfc="taxonomy_mapping_results/crossareal_dlpfc_mapping_anno.rda"
result_dir_crossareal_m1="taxonomy_mapping_results/crossareal_m1_mapping_anno.rda"
result_dir_crossareal_mtg="taxonomy_mapping_results/crossareal_mtg_mapping_anno.rda"
result_dir_crossareal_s1="taxonomy_mapping_results/crossareal_s1_mapping_anno.rda"
result_dir_crossareal_v1="taxonomy_mapping_results/crossareal_v1_mapping_anno.rda"


# Define arrays for variables specific to each call
mapping_file_paths=("$file_path_greatapes_human")
taxonomy_names=("$taxonomy_name_greatapes_human")
taxonomy_dirs=("$taxonomy_dir_greatapes_human")
result_dirs=("$result_dir_greatapes_human")


## 
for ((index=1; index<${#mapping_file_paths[@]}; index++)); do
    echo $index
    sbatch /home/inkar.kapen/scripts/R/taxonomy/slurm/map_crossareal.slurm "${mapping_file_paths[index]}" $cluster_name "${taxonomy_names[index]}" "${taxonomy_dirs[index]}" "${result_dirs[index]}"
done
wait
