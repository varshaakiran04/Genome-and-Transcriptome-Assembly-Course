#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=lja
#SBATCH --output=/data/users/vkiran/assembly_annotation_course/output_lja_%j.o
#SBATCH --error=/data/users/vkiran/assembly_annotation_course/error_lja_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/vkiran/assembly_annotation_course

apptainer exec \
--bind $WORKDIR,/data/courses/assembly-annotation-course/raw_data \
/containers/apptainer/lja-0.2.sif \
lja -o $WORKDIR/lja_output/ \
--reads $WORKDIR/Mr-0/ERR11437312.fastq.gz \
-t 16
