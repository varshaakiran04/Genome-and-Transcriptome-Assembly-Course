#!/usr/bin/env bash
#SBATCH --job-name=merqury_plots
#SBATCH --output=/data/users/vkiran/assembly_annotation_course/merqury_plots_%j.out
#SBATCH --error=/data/users/vkiran/assembly_annotation_course/merqury_plots_%j.err
#SBATCH --time=00:15:00
#SBATCH --mem=4G
#SBATCH --cpus-per-task=1
#SBATCH --partition=pshort_el8

WORKDIR="/data/users/vkiran/assembly_annotation_course"
CONTAINER="/containers/apptainer/merqury_1.3.sif"
export MERQURY="/usr/local/share/merqury"
cd "$WORKDIR/merqury_output"

RUN="apptainer exec --no-home --bind $WORKDIR --env MERQURY=$MERQURY $CONTAINER"

for name in flye hifiasm lja; do
    $RUN Rscript $MERQURY/plot/plot_spectra_cn.R \
        -f ${name}_merqury.${name}.spectra-cn.hist \
        -o ${name}_merqury.${name}.spectra-cn \
        -z ${name}_merqury.${name}.only.hist
    $RUN Rscript $MERQURY/plot/plot_spectra_cn.R \
        -f ${name}_merqury.spectra-asm.hist \
        -o ${name}_merqury.spectra-asm \
        -z ${name}_merqury.dist_only.hist
done
