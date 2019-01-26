use strict;
use warnings;



my $b_strech;
my $h_strech;
my $t_strech;

#messschieber (vorlage gehaeuse)
#b=56,1
#t=87,55
#h=22,5

#messschieber (ethernet shield)
#b=53,15
#t=70,7
#h=32+3 loet+2,5 ueberhang = 37,5

#diff
#b=-2,95
#t=-16.85
#h=15

$b_strech = -2.95;
$t_strech = -16.85;
$h_strech = 15;
$b_strech = 7.05;

my %rep;

# top
$rep{"v -54.50028 c"} = $b_strech;
$rep{"h -23.499233 v"} = $t_strech;
$rep{"h 23.499233 v"} = $t_strech;

# front
$rep{"h -61.400265 c"} = $b_strech;
$rep{"h 48.748243 c"} = $b_strech;
$rep{"m 29.618268,"} = -$b_strech;
$rep{"v -25.7997 c"} = $h_strech;
$rep{",186.83814 h"} = -$h_strech;

# side (clipping)
$rep{"h -85.69997 c"} = $t_strech;
$rep{"h 73.386965 c"} = $t_strech;
$rep{"m 90.23325,"} = $t_strech;
$rep{"v -10.299355 h"} = $h_strech;
$rep{"v 10.299355 h"} = $h_strech;
$rep{",84.0387 h"} = -$h_strech;





#m 54.733575,107.43845 h -12.000088 v -3.09986
foreach my $key (keys(%rep)) {
	$key =~ /([0123456789\.]+)/;
	$rep{$key} = sprintf("%.8f", $1 + $rep{$key});
	my $temp = $key;
	$temp =~s /([0123456789\.]+)/$rep{$key}/;
	$rep{$key} = $temp;
}

foreach my $key (keys(%rep)) {
	print $key."->".$rep{$key}."\n";
}

open (FILE, "03_box.svg");
open (OUT, ">kill.svg");

while (<FILE>) {
	my $line = $_;
	#look for long paths, there are exactly three of them
	#d="m 142.88073,136.76538 c 0,0.41381 -0.33603,0.7493 -0.74983,0.7493 h -14.43779 v 1.50019 c 0,0.41381 -0.33602,0.74983 -0.74983,0.74983 h -7.49987 c -0.41408,0 -0.7501,-0.33602 -0.7501,-0.74983 v -1.50019 h -17.62442 v 1.50019 c 0,0.41381 -0.33602,0.74983 -0.74983,0.74983 h -7.500411 c -0.413808,0 -0.749829,-0.33602 -0.749829,-0.74983 v -1.50019 h -14.437254 c -0.414338,0 -0.750358,-0.33549 -0.750358,-0.7493 v -40.875477 c 0,-0.4138 0.33602,-0.74983 0.750358,-0.74983 h 14.437254 v -1.50018 c 0,-0.41381 0.336021,-0.74983 0.749829,-0.74983 h 7.500411 c 0.41381,0 0.74983,0.33602 0.74983,0.74983 v 1.50018 h 17.62442 v -1.50018 c 0,-0.41381 0.33602,-0.74983 0.7501,-0.74983 h 7.49987 c 0.41381,0 0.74983,0.33602 0.74983,0.74983 v 1.50018 h 14.43779 c 0.4138,0 0.74983,0.33603 0.74983,0.74983 z"
	
	#??d="m 7.8,62.3 -> clipping
	#d="m 0,0 c 0,-1.564 -1.27 -> top
	#???d="m 221,358 -> side
	
	
	if ($line =~ / d="m/) {
		my $line_mod = $line;
		foreach my $key (keys(%rep)) {
			if (index($line_mod, $key) != -1) {
				substr($line_mod, index($line_mod, $key), length($key)) = $rep{$key};
				#print $line;
				#print $line_mod;
			}
		}
		print OUT $line_mod;
	} 
	else {
		print OUT $line;
	}
}
close (OUT);
close (FILE);