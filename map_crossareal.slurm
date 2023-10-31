#!/bin/bash
#SBATCH --job-name=mapping_cells_job    # Job name
#SBATCH --mail-type=END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=inkar.kapen@alleninstitute.org     # Where to send mail  
#SBATCH --ntasks=1                    # Run on a single CPU
#SBATCH --mem=256gb                     # Job memory request (per node)
#SBATCH --time=6:00:00               # Time limit hrs:min:sec
#SBATCH --output=mapping_cells_job_%j.log   # Standard output and error log
#SBATCH -e mapping_cells_job_%j.err
#SBATCH --partition celltypes         # Partition used for processing
#SBATCH --tmp=60G                     # Request the amount of space your jobs needs on /scratch/fast
 
pwd; hostname; date
 
# Path to the R script
r_script="/home/inkar.kapen/scripts/R/taxonomy/slurm_map_cells.R"

# Extract variables specific to this call
mapping_file_path=$1
cluster_name=$2
taxonomy_name=$3
taxonomy_dir=$4
result_dir=$5
    
# Call the R script with the variables
date
echo "Running a python script on a single thread"
singularity exec --cleanenv docker://njjai/scrattch_mapping:0.5 Rscript "$r_script" "$mapping_file_path" "$cluster_name" "$taxonomy_name" "$taxonomy_dir" "$result_dir" &
echo "Finished running a python script on a single thread"
date
wait
