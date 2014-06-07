
use v5.18;

package game1::object::gun::bullet;

use Data::Dumper;
use game1::gun;

use Moose;
extends 'game1::object';


has 'color' => { is      => 'rw',
                 isa     => 'game1::color',
                 default => sub{ game1::color -> new( 'black' ) } };


sub fire
{
        my $self = shift;


}

1;
