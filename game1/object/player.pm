
use v5.40;

package game1::object::player;

use Data::Dumper;
use game1::object::gun;
use game1::position;

use Moose;
extends 'game1::object';

has 'gun' => (
    is      => 'rw',
    isa     => 'game1::object::gun',
    default => sub{ game1::object::gun->new() }
);


sub BUILD
{
    my $self = shift;

    $self->name( 'Player' );
    $self->gun->position( game1::position->new( x => 21, y => 20 ) );

    return;
}


1;
