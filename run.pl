
use v5.40;
use File::Basename;
use lib dirname (__FILE__);

package main;

use game1;

my $game = game1 -> new();
$game -> go();


1;
