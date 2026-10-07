#!/usr/bin/env bash

#SBATCH --time=12:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=8
#SBATCH --job-name=trinity
#SBATCH --output=/data/users/vkiran/assembly_annotation_course/output_trinity_%j.o
#SBATCH --error=/data/users/vkiran/assembly_annotation_course/error_trinity_%j.e
#SBATCH --partition=pibu_el8

module load Trinity/2.15.1-foss-2021a

WORKDIR=/data/users/vkiran/assembly_annotation_course

Trinity \
--seqType fq \
--left $WORKDIR/fastp_output/ERR754081_1.trimmed.fastq.gz \
--right $WORKDIR/fastp_output/ERR754081_2.trimmed.fastq.gz \
--CPU 16 \
--max_memory 64G \
--output $WORKDIR/trinity_output/