# Genome and transcriptome assembly of *Arabidopsis thaliana* (Mr-0)

Scripts for the Assembly & Annotation course (University of Bern), run on the IBU HPC cluster with SLURM and Apptainer containers.

- **Accession:** Mr-0, PacBio HiFi (ERR11437312)
- **Transcriptome:** RNA-seq from accession Sha, Illumina paired-end (ERR754081)
- **Reference:** *A. thaliana* TAIR10 (Col-0), Ensembl Plants release 57

## Pipeline

| Step | Tool | Version | Purpose |
|---|---|---|---|
| Read QC | FastQC, fastp | see scripts | Read quality, adapter trimming |
| k-mer profiling | Jellyfish, GenomeScope | see scripts | Genome size, heterozygosity (k = 21) |
| Genome assembly | Flye | 2.9.5 | Repeat-graph assembler |
| | hifiasm | 0.25.0 | HiFi, haplotype-aware (primary contigs `p_ctg` used) |
| | LJA | 0.2 | de Bruijn graph assembler for HiFi |
| Transcriptome assembly | Trinity | 2.15.1 | de novo assembly from RNA-seq |
| Evaluation | BUSCO | 5.7.1 | Gene completeness (brassicales_odb10, offline mode) |
| | QUAST | 5.2.0 | Contiguity, with and without reference |
| | Merqury | 1.3 | Base accuracy (QV) and k-mer completeness |
| Comparison | nucmer / mummerplot | MUMmer4 | Dot plots against the reference and between assemblies |

## Scripts

Run in numerical order. 
| Script | What it does |
|---|---|
| `scripts/01_run_fastqc.sh` | Read quality check (FastQC) |
| `scripts/02_run_fastp.sh` | Read quality filtering and statistics (fastp) |
| `scripts/03_run_jellyfish.sh` | k-mer counting (Jellyfish); the histogram is used for GenomeScope |
| `scripts/04_run_flye.sh` | Flye assembly |
| `scripts/05_run_hifiasm.sh` | hifiasm assembly |
| `scripts/06_run_lja.sh` | LJA assembly |
| `scripts/07_run_trinity.sh` | Trinity transcriptome assembly |
| `scripts/08_busco.sh` | BUSCO on the three genome assemblies |
| `scripts/08a_busco_trinity.sh` | BUSCO on the Trinity transcriptome |
| `scripts/09_quast.sh` | QUAST, with and without reference |
| `scripts/10_merqury.sh` | Merqury (k = 21) |
| `scripts/10a_merqury_plots.sh` | Merqury plots |
| `scripts/11_mummer.sh` | nucmer and mummerplot |

## Notes

- Jobs were submitted with `sbatch`; the partition and resources are set in the `#SBATCH` lines of each script.
- BUSCO runs in `--offline` mode with a manually downloaded lineage in `busco_downloads/`.
- Merqury runs with `apptainer exec --no-home` so the container does not load R packages from the personal R library, which caused the plotting step to fail.
- Raw reads, assemblies and other large outputs are not included in this repository.

## Results summary (Mr-0)

GenomeScope (k = 21) estimated a genome size of about 144.8 Mb and a heterozygosity of 0.0556%, so Mr-0 is nearly homozygous.

| Metric | Flye | hifiasm | LJA |
|---|---|---|---|
| BUSCO complete (brassicales_odb10) | 99.9% | 99.9% | 99.9% |
| BUSCO duplicated | 1.0% | 1.0% | 1.0% |
| Contigs | 64 | 611 | 483 |
| Total length | 138.9 Mb | 167.0 Mb | 144.0 Mb |
| N50 | 5 Mb | 10 Mb | 14 Mb |
| Merqury QV | 69.1 | 54.7 | 55.0 |
| Merqury k-mer completeness | 99.21% | 99.40% | 99.31% |

All three assemblies recover essentially the full gene set. Flye is the most accurate and has the fewest contigs, LJA is the most contiguous, and hifiasm's assembly is the largest, probably because it retains redundant sequence. This is one run per assembler.