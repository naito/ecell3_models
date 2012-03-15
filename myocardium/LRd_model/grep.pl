#!/usr/bin/perl -w

use strict;

open(IN,"list.txt");
#open(IN,"clancy.txt");
while(<IN>){
    my @tmp = split(/[\t\s]+/,$_);
    print "###", $tmp[-2],"\n";
#    system("grep \"$tmp[-2]\" INa_Clancy.em >>out2.txt");
    system("grep \"$tmp[-2]\" INa_1795insD3.em >>out.txt");
}
close(IN);
