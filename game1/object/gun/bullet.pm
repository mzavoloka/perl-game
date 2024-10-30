
use v5.40;

package game1::object::gun::bullet;

use Data::Dumper;
use game1;

use Moose;
extends 'game1::object';


has 'initial_position' => (
    is      => 'rw',
    isa     => 'game1::position',
    default => sub{ game1->player()->gun() }
);

sub init
{
    my $self = shift;

    $self->view()->color( 'black' );

    return;
}

sub fire
{
    my $self = shift;

    $self->move();

    return;
}


1;
