## Background

To increase the total number of reads per sample, 
it is common to run samples multiple times in separate runs on the Illumina NextSeq500. 
The outputs are different folders with filenames that are the exactly the same 
(unless there are changes made to the "SampleSheet.csv").
The NextSeq500 flowcell has a single flowcell, with four interconnected regions that are 
called "Lanes" which is confusing when compared to other Illumina Instruments
that have multiple Lanes that can be run independently and with separate samples.
To reduce confusion, and to save researcher's time, we concatenate the four "lanes"
into a single read file. If paired-end reads are used, there is a single file for 
Read1 and for Read2 (usually identified by "R1" and "R2" respectively) for each sample.  

But when multiple runs create separate folders, each containing files with 
identical names, they also have to be concatenated together. The following script 
was written by Evan Linde after I spent a couple days trying to figure this out.
It's posted here with some explanations for what the lines are doing.

## The Script

```
for fpath in run1/*.fastq.gz; do
    f=${fpath##*/}
    cat run*/${f} > concatenated/${f}
    # if you want a new filename see below
done
```
----------------------------------

## Explaining the script

`for fpath in run1/*.fastq.gz; do`
defines the `fpath` variable giving it essentially a value 
until it runs out of `run1/*.fastq.gz` files in the run1 directory

`    f=${fpath##*/}`
this is parameter expansion that defines "f" as the `$fpath` filename 
deleting the `run/` directory from the filenames (iterating through the filenames).
Although it looks like it might remove filenames leaving only the suffix
it doesn't as the "/" character shows it's removing the characters of 
`run1/*fastq.gz` up to and including the directory separator "/" leaving *`fastq.gz`.
Thus, "f" (or `$f`) becomes the filenames. 

`    cat run*/${f} > concatenated/${f}`
this concatenates any file with the same name `${f}` in any folders 
named `run*` (below the current directory) and outputs the concatenated 
files to the concatenated directory with the same filename.
In this case, if any folders had names that were different from the filenames 
in the run1 folder, they would be skipped.

`done`
Finished.

It seems pretty simple, but without parameter expansion is more tricky 
than one might think. Because this needs to be done on a Windows-based system
(the NextSeq uses Windows 7 and a "mapped" remote drive to stream the sequence data), it has to use
a GitBash terminal or CygWin terminal. This essentially prevents me from 
asking questions on StackOverflow, where I often lurk when doing scripting.

## Caveats

As mentioned above, this works when each folder has the same number of files, 
all with the same name. As you can imagine, this might not always happen, so
Evan helped create a more robust version shown below.

## Script when all files are not the same

Here Evan went beyond my scripting skills, so this is mostly his words, not mine. 
When you can’t be sure that all the same files exist in every directory
all the files need to be in order so that files are concatenated in the right order.

`dirs=(run1, run2, run3, ...)`  <== some ordered list of directory names

Then make sure the concatenated directory exists and is empty since we're only 
using the append ">>" operator
```
[[ -d concatenated ]] && rm -rf concatenated
mkdir concatenated
for d in ${dirs[@]}; do
    pushd ${d}
    for f in *.fastq.gz; do
        cat ${f} >> ../concatenated/${f}
    done
    popd
done
```
If you want to add a suffix onto the concatenated files, this should do the trick:

`f_suffix=${f/.fastq.gz/_all.fastq.gz}`

Then use `${f_suffix}` as your output file in the concatenated directory.

## Thanks Evan!





