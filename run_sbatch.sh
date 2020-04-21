sbatch --array=1-$(( $( wc -l /ptmp/fbeyer/BIDS_test/participants.tsv | cut -f1 -d' ' ) - 1 )) sbatch.slurm
