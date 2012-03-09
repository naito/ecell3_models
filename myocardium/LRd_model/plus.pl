#!/usr/bin/perl -w

use strict;

open(IN,$ARGV[0]);
while(<IN>){
    if(/\"V\"/){
	print $_;
	my $line = $_;
	$line =~ s/V/EPI/g;
	print $line;
	$line =~ s/EPI/END/g;
	print $line;
	$line =~ s/END/M/g;
	print $line;
    }
    else{
	print $_;
    }
}
close(IN);
