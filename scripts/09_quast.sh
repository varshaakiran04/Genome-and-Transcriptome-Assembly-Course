#!/usr/bin/env bash

#SBATCH --time=02:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=8
#SBATCH --job-name=quast
#SBATCH --output=/data/users/vkiran/assembly_annotation_course/output_quast_%j.o
#SBATCH --error=/data/users/vkiran/assembly_annotation_course/error_quast_%j.e
#SBATCH --partition=pshort_el8

WORKDIR=/data/users/vkiran/assembly_annotation_course
REFDIR=/data/courses/assembly-annotation-course/references

# With reference
apptainer exec --bind /data/ /containers/apptainer/quast_5.2.0.sif \
quast.py \
$WORKDIR/flye_output/assembly.fasta \
$WORKDIR/hifiasm_output/Mr-0.asm.bp.p_ctg.fa \
$WORKDIR/lja_output/assembly.fasta \
-r $REFDIR/[REFERENCE_FASTA] \
--features $REFDIR/[REFERENCE_GFF] \
--labels flye,hifiasm,lja \
--eukaryote \
--est-ref-size 145000000 \
--threads 8 \
-o $WORKDIR/quast_output/with_ref

# Without reference
apptainer exec --bind /data/ /containers/apptainer/quast_5.2.0.sif \
quast.py \
$WORKDIR/flye_output/assembly.fasta \
$WORKDIR/hifiasm_output/Mr-0.asm.bp.p_ctg.fa \
$WORKDIR/lja_output/assembly.fasta \
--labels flye,hifiasm,lja \
--eukaryote \
--est-ref-size 145000000 \
--threads 8 \
-o $WORKDIR/quast_output/no_ref