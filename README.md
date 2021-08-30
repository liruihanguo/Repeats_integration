# Repeats integration
Integration and statistics of repeat annotaion
# Data prepareing
Four GFF files from repeat annotations: denovo.gff, trf.gff, repeatmasker.gff, proteinmask.gff  
A genome File: Genome.fa 
# merge the overlaps among all the repeats  
cat denovo.gff trf.gff repeatmasker.gff proteinmask.gff  > all.gff  
perl merge_overlap.pl all.gff >merge_overlap.gff  
# classify each kind of repeats  
cat denovo.gff repeatmasker.gff proteinmask.gff  > all_without_trf.gff  
perl stat.pl -denovo -trf -repeatmasker -proteinmask  Genome.fa  
