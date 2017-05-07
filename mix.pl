#!/usr/bin/perl -i
use strict;
use warnings;
#use Math::Round;

my $total_layers=266;
my $E_old=0;
my $E_new=0;
my $B=0;
my $current_layer=0;
#printf("%.3f", 3.1415926535); 
$^I = '.bak';

while (<>){
	if(/^;\h+layer(\h+(-?\d*\.?\d+))/){
		$current_layer=$2;
		print;
	}
		elsif(/^G[01](\h+X(-?\d*\.?\d+))?(\h+Y(-?\d*\.?\d+))?(\h+Z(-?\d*\.?\d+))?(\h+E(-?\d*\.?\d+))?(\h+F(\d*\.?\d+))?(\h*;\h*([\h\w_-]*)\h*)?/){
			my $X=$2, my $Y=$4, my $Z=$6, my $E=$8, my $F=$10, my $verbose=$12;
			if($E){
				$E_old=$E;
				$B=$E_old*$current_layer/$total_layers;
				$E_new=$E_old-$B;
				print "G1";
				if($X){
					print " X".$X;
				}
				if($Y){
					print " Y".$Y;
				}
				if($Z){
					print " Z".$Z;
				}
				print " E";
				printf("%.5f", $E_new);
				print " B";
				printf("%.5f", $B);
				if($F){
					print " F".$F;
				}
				if($verbose){
					print " ; ".$verbose;
				}
				print "\n";
			}
				else {print;}
		}
		else {
			print;
		}
}
