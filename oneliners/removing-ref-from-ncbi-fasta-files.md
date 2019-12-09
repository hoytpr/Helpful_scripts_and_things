

#### Rsubread doesn't accept ">ref|" headers

Sometimes (I obviously can't say always), you download a genome from NCBI, and find that every scaffold 
header begins with `>ref|` followed by the chromosome info. I don't know or care why, but I did
notice that `Rsubread` from [Bioconductor](https://bioconductor.org/packages/3.10/bioc/vignettes/Rsubread/inst/doc/Rsubread.pdf) 
didn't like them at all. The error was pretty clear:
```
ERROR: repeated chromosome name 'ref' is observed in the FASTA file(s).
```
Soooo, I used a `sed` script to get rid of the `>ref|` and replace it with `>`.
For example, say you have downloaded all the chromosomes from a genome, and then concatenated them together
to create a reference genome for your scRNAseq experiment named `cat9ref.fa`.
The sed script would be:

`sed 's/>[^|]*|/>/; ' cat9ref.fa`

Woo hoo. Not exciting, but more on scRNAseq later
