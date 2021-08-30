#!/usr/bin/perl -w
use strict;
sub usage{
    print STDERR <<USAGE;
    ################################################
      Usage: $0 <file> >STDOUT

      merge overlap region in a GFF file.
    ################################################
USAGE
    exit;
}
&usage if(@ARGV !=1);
############################  BEGIN MAIN  ############################
    my %all;
    open (IN,"$ARGV[0]") or die($!);
    while(my $line=<IN>){
        my @info=(split /\s+/,$line);
        push @{$all{$info[0]}{$info[6]}},[@info[3,4]];
    }
    close IN;
    foreach my $e (sort {length $a<=>length $b or $a cmp $b} keys %all){
        foreach my $s (keys %{$all{$e}}){
            @{$all{$e}{$s}}=sort {$a->[0] <=>$b->[0] or $a->[1]<=>$b->[1]} @{$all{$e}{$s}};
            my ($t_st,$t_ed)=@{(shift @{$all{$e}{$s}})};
            foreach my $j (@{$all{$e}{$s}}){
                if($j->[0]>$t_ed+1){
                    print "$e\tRepeat_merged\tRepeat_region\t$t_st\t$t_ed\t.\t$s\t.\tID=Repeat_merged:$t_st-$t_ed;\n";
                    ($t_st,$t_ed)=@{$j};
                }elsif($j->[1]>$t_ed){
                    $t_ed=$j->[1];
                }
            }
            print "$e\tRepeat_merged\tRepeat_region\t$t_st\t$t_ed\t.\t$s\t.\tID=Repeat_merged:$t_st-$t_ed;\n";
        }
    }
############################   END  MAIN  ############################
