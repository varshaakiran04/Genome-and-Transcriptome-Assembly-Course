#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=flye
#SBATCH --output=/data/users/vkiran/assembly_annotation_course/output_flye_%j.o
#SBATCH --error=/data/users/vkiran/assembly_annotation_course/error_flye_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/vkiran/assembly_annotation_course

apptainer exec \
--bind $WORKDIR,/data/courses/assembly-annotation-course/raw_data \
/containers/apptainer/flye_2.9.5.sif \
flye --pacbio-hifi $WORKDIR/Mr-0/ERR11437312.fastq.gz \
--out-dir $WORKDIR/flye_output/ \
--threads 16

