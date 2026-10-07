#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --time=02:00:00
#SBATCH --job-name=fastp
#SBATCH --output=/data/users/vkiran/assembly_annotation_course/output_fastp_%j.o
#SBATCH --error=/data/users/vkiran/assembly_annotation_course/error_fastp_%j.e
#SBATCH --partition=pshort_el8

module load fastp/0.23.4-GCC-10.3.0

WORKDIR=/data/users/vkiran/assembly_annotation_course

# RNA-seq trim & filter
fastp \
-i $WORKDIR/RNAseq_Sha/ERR754081_1.fastq.gz \
-I $WORKDIR/RNAseq_Sha/ERR754081_2.fastq.gz \
-o $WORKDIR/fastp_output/ERR754081_1.trimmed.fastq.gz \
-O $WORKDIR/fastp_output/ERR754081_2.trimmed.fastq.gz \
--json $WORKDIR/fastp_output/RNAseq_Sha_fastp.json \
--html $WORKDIR/fastp_output/RNAseq_Sha_fastp.html \
--thread 4

# PacBio HiFi: no filtering, just get total base count stats
fastp \
-i $WORKDIR/Mr-0/ERR11437312.fastq.gz \
--disable_adapter_trimming \
--disable_quality_filtering \
--disable_length_filtering \
--json $WORKDIR/fastp_output/Mr-0_fastp.json \
--html $WORKDIR/fastp_output/Mr-0_fastp.html \
--thread 4