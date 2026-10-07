#!/usr/bin/env bash

#SBATCH --time=02:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=nucmer
#SBATCH --output=/data/users/vkiran/assembly_annotation_course/output_nucmer_%j.o
#SBATCH --error=/data/users/vkiran/assembly_annotation_course/error_nucmer_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/vkiran/assembly_annotation_course
REFDIR=/data/courses/assembly-annotation-course/references
REF=$REFDIR/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
cd $WORKDIR/mummer_output

CONTAINER="apptainer exec --bind /data/ /containers/apptainer/mummer4_gnuplot.sif"

# Each assembly vs reference 
$CONTAINER nucmer --prefix=flye_vs_ref --breaklen 1000 --mincluster 1000 $REF $WORKDIR/flye_output/assembly.fasta
$CONTAINER mummerplot -R $REF -Q $WORKDIR/flye_output/assembly.fasta --filter -t png --large --layout --fat -p flye_vs_ref flye_vs_ref.delta

$CONTAINER nucmer --prefix=hifiasm_vs_ref --breaklen 1000 --mincluster 1000 $REF $WORKDIR/hifiasm_output/Mr-0.asm.bp.p_ctg.fa
$CONTAINER mummerplot -R $REF -Q $WORKDIR/hifiasm_output/Mr-0.asm.bp.p_ctg.fa --filter -t png --large --layout --fat -p hifiasm_vs_ref hifiasm_vs_ref.delta

$CONTAINER nucmer --prefix=lja_vs_ref --breaklen 1000 --mincluster 1000 $REF $WORKDIR/lja_output/assembly.fasta
$CONTAINER mummerplot -R $REF -Q $WORKDIR/lja_output/assembly.fasta --filter -t png --large --layout --fat -p lja_vs_ref lja_vs_ref.delta

# Assemblies vs each other
$CONTAINER nucmer --prefix=flye_vs_hifiasm --breaklen 1000 --mincluster 1000 $WORKDIR/flye_output/assembly.fasta $WORKDIR/hifiasm_output/Mr-0.asm.bp.p_ctg.fa
$CONTAINER mummerplot -R $WORKDIR/flye_output/assembly.fasta -Q $WORKDIR/hifiasm_output/Mr-0.asm.bp.p_ctg.fa --filter -t png --large --layout --fat -p flye_vs_hifiasm flye_vs_hifiasm.delta

$CONTAINER nucmer --prefix=flye_vs_lja --breaklen 1000 --mincluster 1000 $WORKDIR/flye_output/assembly.fasta $WORKDIR/lja_output/assembly.fasta
$CONTAINER mummerplot -R $WORKDIR/flye_output/assembly.fasta -Q $WORKDIR/lja_output/assembly.fasta --filter -t png --large --layout --fat -p flye_vs_lja flye_vs_lja.delta

$CONTAINER nucmer --prefix=hifiasm_vs_lja --breaklen 1000 --mincluster 1000 $WORKDIR/hifiasm_output/Mr-0.asm.bp.p_ctg.fa $WORKDIR/lja_output/assembly.fasta
$CONTAINER mummerplot -R $WORKDIR/hifiasm_output/Mr-0.asm.bp.p_ctg.fa -Q $WORKDIR/lja_output/assembly.fasta --filter -t png --large --layout --fat -p hifiasm_vs_lja hifiasm_vs_lja.delta