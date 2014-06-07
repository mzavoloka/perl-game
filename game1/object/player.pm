
use v5.18;

package game1::object::player;

use Data::Dumper;
use game1::gun;

use Moose;
extends 'game1::object';

has 'gun' => ( is      => 'rw',
               isa     => 'game1::gun',
               default => sub{ game1::gun -> new() } );


sub init
{
        my $self = shift;

        $self -> name( 'Player' );

        return;
}


1;
