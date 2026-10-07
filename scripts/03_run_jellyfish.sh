#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=40G
#SBATCH --time=02:00:00
#SBATCH --job-name=jellyfish
#SBATCH --output=/data/users/vkiran/assembly_annotation_course/output_jellyfish_%j.o
#SBATCH --error=/data/users/vkiran/assembly_annotation_course/error_jellyfish_%j.e
#SBATCH --partition=pshort_el8

module load Jellyfish/2.3.0-GCC-10.3.0

WORKDIR=/data/users/vkiran/assembly_annotation_course

jellyfish count -C -m 21 -s 5G -t 4 \
  <(zcat $WORKDIR/Mr-0/ERR11437312.fastq.gz) \
  -o $WORKDIR/kmer_output/reads.jf

jellyfish histo -t 4 $WORKDIR/kmer_output/reads.jf > $WORKDIR/kmer_output/reads.histo