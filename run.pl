
use v5.40;
use lib '.';

package main;

use game1;

my $game = game1 -> new();
$game -> go();


1;
