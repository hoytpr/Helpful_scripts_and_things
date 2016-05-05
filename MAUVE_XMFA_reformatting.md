###Intro

To get an XMFA file that works in [ClonalFrame](https://github.com/xavierdidelot/ClonalFrameML) by Xavier Didelot, 
the **original** XMFA output from [MAUVE](http://darlinglab.org/mauve/mauve.html) multiple genome alignment software
will not work.

MAUVE is maintained by Aaron Darling ("koadman") and it's great software for aligning MANY 
bacterial (or smaller) genomes, and can do large genomes as well. The MAUVE output includes a non-standard 
formatted XMFA file which is difficult to use for downstream genomic recombination analyses. ClonalFrame 
and [ClonalOrigin](https://github.com/xavierdidelot/ClonalOrigin) are a powerful suite of tools to identify
microevolution.  

###Getting the XMFA file you need.

First: Keep all your files in one directory. It's just easier that way. 

Second: Get ClonalOrigin and all it's associated programs as described 
[HERE.](https://github.com/xavierdidelot/ClonalOrigin/wiki/Usage) 

START:

1. Align genomes with Progressive Mauve

2. Using the Progressive Mauve outputs, run StripSubsetsLCB as described 
[here](https://github.com/xavierdidelot/ClonalOrigin/wiki/Usage) using the MAUVE output .xmfa and .bbcols files.
It should look something like:

     
     **"stripSubsetLCBs full_alignment.xmfa full_alignment.xmfa.bbcols core_alignment.xmfa 500"**

3. the StripsubsetsLCB output new XMFA file (not the original from MAUVE) now has only the CORE alignment region
where all the lines and line-lengths are correct. 

However, the header lines often have additional information such as 
genome position numbers that must be removed, leaving only the organism name (e.g. >S. aureus)
for downstream analyses.

Below is a short script to remove the genome position numbers up to the organism name, 
*if and ONLY if*, your headers look like mine (for example):

    >2:3289121-3291310 + e.anophelisNUHP1.fas

sed can be used on the StripsubsetsLCB output XMFA file:
   
    sed -r 's/^>..* />/' your_xmfa_file.xmfa

I'm not a great coder so please feel free to improve on this one-liner (thanks Dana). It seems to work for me.

Xavier Didelot suggested the following Perl script based on my initial scripting efforts:
    
    perl -i.bk -wpe's/^>..* -*/>/' your_xmfa_file.xmfa

It is very likely that
    
    perl -i.bk -wpe's/^>.* />/' your_xmfa_file.xmfa

Will work just as well. The next step is to [infer clonal geneology]  (https://github.com/xavierdidelot/ClonalOrigin/wiki/Usage#infer-clonal-genealogy)
which will take several days of compute time, and leave you with a consensus tree.

