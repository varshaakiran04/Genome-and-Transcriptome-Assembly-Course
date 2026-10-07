#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=02:00:00
#SBATCH --job-name=fastqc
#SBATCH --output=/data/users/vkiran/assembly_annotation_course/output_fastqc_%j.o
#SBATCH --error=/data/users/vkiran/assembly_annotation_course/error_fastqc_%j.e
#SBATCH --partition=pshort_el8

WORKDIR=/data/users/vkiran/assembly_annotation_course

apptainer exec \
--bind $WORKDIR,/data/courses/assembly-annotation-course/raw_data \
/containers/apptainer/fastqc-0.12.1.sif \
fastqc $WORKDIR/Mr-0/*.fastq.gz $WORKDIR/RNAseq_Sha/*.fastq.gz \
-o $WORKDIR/fastqc_output/