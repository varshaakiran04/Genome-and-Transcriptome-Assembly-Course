#!/usr/bin/env bash

#SBATCH --time=02:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=8
#SBATCH --job-name=busco
#SBATCH --output=/data/users/vkiran/assembly_annotation_course/output_busco_%j.o
#SBATCH --error=/data/users/vkiran/assembly_annotation_course/error_busco_%j.e
#SBATCH --partition=pshort_el8

WORKDIR=/data/users/vkiran/assembly_annotation_course
OUTPUT_DIR=$WORKDIR/busco_output
CONTAINER=/containers/apptainer/busco_5.7.1.sif
MODE=genome
LINEAGE=brassicales_odb10

rm -rf $OUTPUT_DIR/busco_flye $OUTPUT_DIR/busco_hifiasm $OUTPUT_DIR/busco_lja

apptainer exec --bind /data/ $CONTAINER busco \
    -i $WORKDIR/flye_output/assembly.fasta \
    -o busco_flye \
    --out_path $OUTPUT_DIR \
    -m $MODE \
    -l $LINEAGE \
    --offline \
    --download_path $WORKDIR/busco_downloads/ \
    -c $SLURM_CPUS_PER_TASK \
    -f

apptainer exec --bind /data/ $CONTAINER busco \
    -i $WORKDIR/hifiasm_output/Mr-0.asm.bp.p_ctg.fa \
    -o busco_hifiasm \
    --out_path $OUTPUT_DIR \
    -m $MODE \
    -l $LINEAGE \
    --offline \
    --download_path $WORKDIR/busco_downloads/ \
    -c $SLURM_CPUS_PER_TASK \
    -f

apptainer exec --bind /data/ $CONTAINER busco \
    -i $WORKDIR/lja_output/assembly.fasta \
    -o busco_lja \
    --out_path $OUTPUT_DIR \
    -m $MODE \
    -l $LINEAGE \
    --offline \
    --download_path $WORKDIR/busco_downloads/ \
    -c $SLURM_CPUS_PER_TASK \
    -f