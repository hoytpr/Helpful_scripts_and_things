#### Simple recursive filename extension change 

We recently opened up our new HPC for all researchers and
in the process updated to a different scheduler. 
This meant all our previous job submission scripts 
(which were of the ".pbs" type) had to be changed over to 
the new style using ".sbatch" as the suffix (extension). 

Briefly, this was harder to do in BASH than I had expected. Recursiveness was hard. 
But after a few searches finally found a simple version of a script that worked well
on our HPC. 

**NOTE** this only changes the ***extensions*** of the submission scripts. I would 
like to be experienced enough to tease out the subtleties of actually 
re-writing (reformatting actually) the submission script headers etc. but not today.

So I used this:

```
find . -iname "*.pbs" -exec rename .pbs .sbatch '{}' \;
```

The `-exec` tells `find` to execute `rename` for every file. The `'{}'` represents the path of any found file. 
Finally the `\;` marks the end of `exec`.

You can use this to change the extension of any files to another extension
by changing `.pbs` and or `.sbatch` to whatever you need. 

Not a big script or anything, but I tried using `basename` and then `sed` substitution, and a 
few crazy things before this one worked. Hope it helps someone. 