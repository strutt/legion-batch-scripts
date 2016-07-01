#!/bin/bash -l

# arguments for node creation program

#$ -S /bin/bash
#$ -l h_rt=1:00:0
#$ -l mem=4G
#$ -l tmpfs=10G
#$ -pe smp 4
#$ -t 130-434
#$ -N makeDataQualityTrees
#$ -wd /home/ucapstr/Scratch/output




# environment shizzle, some of this may be redundant
cd $TMPDIR
source /home/ucapstr/Scratch/root-6.06.02/bin/thisroot.sh
export ANITA_UTIL_INSTALL_DIR=/home/ucapstr/Repositories/Install
export ANITA_CALIB_DIR=/home/ucapstr/Repositories/Install/share/anitaCalib
export LD_LIBRARY_PATH=$ROOTSYS/lib:$ANITA_UTIL_INSTALL_DIR/lib:$LD_LIBRARY_PATH
export OUTPUT_DIR=$TMPDIR



# run the program
/home/ucapstr/UCL/ANITA/anita3Analysis/decimatedDistributions/makeDataQualityTrees $SGE_TASK_ID

# copy output to proper place
jobOutputDir=/home/ucapstr/Scratch/output$JOB_ID
mkdir -p $jobOutputDir
rsync -ravh --progress $TMPDIR/*.root $jobOutputDir
mv /home/ucapstr/Scratch/output/makeDataQualityTrees.o$JOB_ID.$SGE_TASK_ID $jobOutputDir
mv /home/ucapstr/Scratch/output/makeDataQualityTrees.e$JOB_ID.$SGE_TASK_ID $jobOutputDir
mv /home/ucapstr/Scratch/output/makeDataQualityTrees.po$JOB_ID.$SGE_TASK_ID $jobOutputDir
mv /home/ucapstr/Scratch/output/makeDataQualityTrees.pe$JOB_ID.$SGE_TASK_ID $jobOutputDir
