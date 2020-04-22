#!/bin/bash

#singularity run /data/u_fbeyer_software/mriqc/mriqc_0.15.0.simg -B /data/pt_nro186_lifeupdate/Data/BIDS/ -B /data/pt_nro186_lifeupdate/Data/BIDS/derivatives/mriqc

singularity run -B 
/ptmp/BIDS_test/,/ptmp/fbeyer/BIDS_test_output,/ptmp/fbeyer/BIDS_test_wd 
/u/fbeyer/mriqc_0.15.0.simg /ptmp/BIDS_test/ /ptmp/BIDS_test_output
participant -m T1w -w /ptmp/fbeyer/BIDS_test_wd
