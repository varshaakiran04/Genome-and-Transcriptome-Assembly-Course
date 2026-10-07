#!/usr/bin/env bash
#SBATCH --job-name=busco_trinity
#SBATCH --output=/data/users/vkiran/assembly_annotation_course/output_busco_trinity_%j.o
#SBATCH --error=/data/users/vkiran/assembly_annotation_course/error_busco_trinity_%j.e
#SBATCH --time=02:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=8
#SBATCH --partition=pshort_el8


WORKDIR=/data/users/vkiran/assembly_annotation_course

apptainer exec --bind /data/ /containers/apptainer/busco_5.7.1.sif busco \
    -i $WORKDIR/trinity_output.Trinity.fasta \
    -o busco_trinity \
    --out_path $WORKDIR/busco_output \
    -m transcriptome \
    -l brassicales_odb10 \
    --offline \
    --download_path $WORKDIR/busco_downloads/ \
    -c $SLURM_CPUS_PER_TASK \
    -f
