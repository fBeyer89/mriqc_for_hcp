sbatch --array=1-$(( $( wc -l /ptmp/fbeyer/BIDS_test/participants.tsv | cut -f1 -d' ' ) - 1 )) sbatch.slurm



singularity run -B /ptmp/fbeyer/BIDS_test,/ptmp/fbeyer/BIDS_test/derivatives,/ptmp/fbeyer/wd /u/fbeyer/mriqc_0.15.0.simg /ptmp/fbeyer/BIDS_test /ptmp/fbeyer/BIDS_test/derivatives/mriqc participant -m T1w -w /ptmp/fbeyer/wd
