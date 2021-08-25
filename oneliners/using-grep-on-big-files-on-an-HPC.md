#### The shell command `grep`

You'll have to trust me on this one but `grep` works just fine on big files on an HPC, as long as you 
tell it to **use the -F flag for --fixed-strings**

The `-F` flag is defined as:
"Interpret patterns as fixed strings, not regular expressions. (-F is specified by POSIX.)"

What does -F do? Well, as far as I can determine, it minimizes the amount of characters or character sets that `grep` has to search through for pattern matching, and uses only those present in the ASCII group. In other words, 127 characters only. 

On our HPC, it made running grep, using a file for patterns, run 5000X faster. Okay, I didn't really benchmark it, but it went from timing out after 24 hours on a "bigmem" node, to fully completing the task in 10 minutes or less on a regular node. So at least 1,440X faster. 

Example using sequencing read names to create a fastq file that is a subset of a larger fastq file. 

```
grep -F -A3 --file=BactR1_Names BactR1_.fastq --no-group-separator > R1BactPlasmid.fastq
```

Also note the `--no-group-separator` prevents you from having to use an `awk` script to clean up the files.
Normally `grep` will place a "--" between regions where there were no matching patterns. 