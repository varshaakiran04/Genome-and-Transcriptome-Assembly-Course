#!/usr/bin/env bash
#SBATCH --job-name=merqury
#SBATCH --output=/data/users/vkiran/assembly_annotation_course/mercury_output_%j.out
#SBATCH --error=/data/users/vkiran/assembly_annotation_course/error_merqury_%j.err
#SBATCH --time=02:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --partition=pshort_el8


WORKDIR="/data/users/vkiran/assembly_annotation_course"
CONTAINER="/containers/apptainer/merqury_1.3.sif"
OUTDIR="$WORKDIR/merqury_output"
READS="$WORKDIR/Mr-0/ERR11437312.fastq.gz"
K=21    
mkdir -p "$OUTDIR"
cd "$OUTDIR"
export MERQURY="/usr/local/share/merqury"

RUN="apptainer exec \
    --no-home \
    --bind $WORKDIR \
    --bind /data/courses/assembly-annotation-course \
    --env MERQURY=$MERQURY \
    $CONTAINER"

# 1. meryl database from HiFi reads
$RUN meryl k=$K count threads=$SLURM_CPUS_PER_TASK memory=60 \
    output reads.meryl "$READS"

# 2. evaluate each assembly (symlinks so merqury gets short local names)
ln -sf "$WORKDIR/flye_output/assembly.fasta"                flye.fa
ln -sf "$WORKDIR/hifiasm_output/Mr-0.asm.bp.p_ctg.fa"       hifiasm.fa
ln -sf "$WORKDIR/lja_output/assembly.fasta"                 lja.fa

for name in flye hifiasm lja; do
    $RUN merqury.sh reads.meryl ${name}.fa ${name}_merqury
done
