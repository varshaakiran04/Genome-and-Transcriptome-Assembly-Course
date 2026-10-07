#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=hifiasm
#SBATCH --output=/data/users/vkiran/assembly_annotation_course/output_hifiasm_%j.o
#SBATCH --error=/data/users/vkiran/assembly_annotation_course/error_hifiasm_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/vkiran/assembly_annotation_course

apptainer exec \
--bind $WORKDIR,/data/courses/assembly-annotation-course/raw_data \
/containers/apptainer/hifiasm_0.25.0.sif \
hifiasm -o $WORKDIR/hifiasm_output/Mr-0.asm -t 16 $WORKDIR/Mr-0/ERR11437312.fastq.gz

