#Written by Peter Hoyt in 2010 hoytpr@gmail.com
#How to make the Perl script work:
#
#Windows
#1. Open Cygwin Window
#2. Change directory to the directory with the .seq files
#3. Copy FinalPH-SeqFiles2MultiFasta.pl to this directory
#4. Run ./FinalPH-SeqFiles2MultiFasta.pl
#5. SeqMulti.fasta is the result, and titles.seq is list of titles
#
#Linux
#1. Change directory to the directory with the .seq files
#2. Copy FinalPH-SeqFiles2MultiFasta.pl to this directory
#3. Run ./FinalPH-SeqFiles2MultiFasta.pl
#4. SeqMulti.fasta is the result, and titles.seq is list of titles
#
#(alternate)
#1. Change script to use full path to the sequence directory. 
#
#In linux, or BioPerl, you may have to un-comment-out the following line
#!/usr/bin/perl
ls *.seq > titles.seq | ls -d *.seq | sed 's/\(.*\).seq$/sed "s\/\\.seq\/.seq1\/g" "&" > \1.seq1/' | sh | wait; echo "waiting" | perl -i.bak -pe 's/\r|\n//g' *.seq1 | wait; echo "waiting" | rm *.bak | wait; echo "waiting" | seqret sequence=@titles.seq sformat=plain SeqMulti.fasta | wait; echo "waiting" | rm *.seq1 