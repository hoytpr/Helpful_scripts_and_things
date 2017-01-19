#Slow running `warg` jobs#
When submitting the XMFA output file from MAUVE, even after fixing the XMFA tiltes, 
running stripSubsetLCBs to generate the core_XMFA file, Inferring clonal genealogy three times, 
running `getClonalTree` on each geneology output, making sure the three trees match, 
and running `blocksplit.pl` on the original core_XMFA file...
my experience (which could be much different than others when working on a different cluster)
is there can be trouble using a script to rapidly submit the (potentially thousands) of 
scripts to the cluster. Maybe it's just different schedulers. We used [Torque] (http://www.adaptivecomputing.com/support/download-center/torque-download/)

For example, Xavier Didelot uses this submission script using a Sun Grid Engine (SGE) manager:
```
#!/bin/sh
#$ -cwd
#$ -S /bin/bash
#$ -t 1-157
export WORKDIR=/state/partition1/warg
mkdir -p $WORKDIR
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/lib
warg -a 1,1,0.1,1,1,1,1,1,0,0,0 -x 1000000 -y 1000000 -z 10000 clonaltree.nwk core_alignment.xmfa.$SGE_TASK_ID   $WORKDIR/core_co.phase2.$SGE_TASK_ID.xml
bzip2 $WORKDIR/core_co.phase2.$SGE_TASK_ID.xml
mv $WORKDIR/core_co.phase2.$SGE_TASK_ID.xml.bz2 .
```

Whereas on our system we set up a bash script which called a generic submission script, For example if the generic submission script was called `generic-clonal.pbs` we (Thanks to JessieJS for this scripting) wrote a bash script to call all the blocks, and use each block's number, to be part of the submission script. But this isn't the point.

My point is that after submitting thousands of blocks for `warg` analyses very rapidly, a few of the jobs were EXTREMELY slow to run. Most of the 1100+ blocks were finished in a day or 3. But a dozen dragged on for months. 

##The Fix##

Those slow jobs are having problems. But you can **stop them, and re-start them**. 
If you look at their progression (the growing output file) you'll see error messages 
such as this in output file `blocksplit453.pbs.o12345`:
```
Got seed 14879935658744796555 from /dev/random
Starting Metropolis-Hastings algorithm.............
....#  0% ....#  2%....#  4%....#  6%....#  8%....# 10%....# 12%....# 14%....# 16%....# 18%....# 
20%....# 22%....# 24%....# 26%....# 28%....# 30%....# 32%....# 34%....# 36%....# 38%....# 40%....# 
42%....# 44%....# 46%Error in computeSiteLL: Invalid Local Tree, happened 0 times
Error in computeSiteLL: Invalid Local Tree, happened 1 times
Error in computeSiteLL: Invalid Local Tree, happened 2 times
Error in computeSiteLL: Invalid Local Tree, happened 3 times
<snip>
Error in computeSiteLL: Invalid Local Tree, happened 100 times
Not reporting any more errors, fix this program!!
....# 48%....# 50%....# 52%....# 
```

These jobs will take months to finish. When you see a `warg` output file (e.g. `blocksplit453.pbs.o12345`) that looks stalled 
You should **stop that job, and restart it** with the same submission script (in this case it would be:
blocksplit453.pbs). It will finish within a few days. If it doesn't, start and stop it again. 

