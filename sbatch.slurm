#!/bin/bash
#
#SBATCH -J mriqc
#SBATCH --time=00:30:00
#SBATCH -n 1
#SBATCH --cpus-per-task=16
#SBATCH --mem-per-cpu=2G
#SBATCH --partition small
# Outputs ----------------------------------
#SBATCH -o log/%x-%A-%a.out
#SBATCH -e log/%x-%A-%a.err
#SBATCH --mail-type=none
# ------------------------------------------

BIDS_DIR="/ptmp/fbeyer/BIDS_test"
DERIVS_DIR="derivatives"

# Designate a templateflow bind-mount point

SINGULARITY_CMD="singularity run --cleanenv -B ${BIDS_DIR}:/tmp -B /ptmp/fbeyer/wd:/tmp/wd -B ${BIDS_DIR}/DERIVS_DIR:/tmp/${DERIVS_DIR} /u/fbeyer/mriqc_1.5.0.simg"

# Parse the participants.tsv file and extract one subject ID from the line corresponding to this SLURM task.
subject=$( sed -n -E "$((${SLURM_ARRAY_TASK_ID} + 1))s/sub-(\S*)\>.*/\1/gp" ${BIDS_DIR}/participants.tsv )


# Compose the command line
cmd="${SINGULARITY_CMD} /tmp /tmp/${DERIVS_DIR} participant -m T1w -w tmp/wd"

# Setup done, run the command
echo Running task ${SLURM_ARRAY_TASK_ID}
echo Commandline: $cmd
eval $cmd
exitcode=$?

# Output results to a table
echo "sub-$subject   ${SLURM_ARRAY_TASK_ID}    $exitcode" >> ${SLURM_JOB_NAME}.${SLURM_ARRAY_JOB_ID}.tsv
echo Finished tasks ${SLURM_ARRAY_TASK_ID} with exit code $exitcode
exit $exitcode
