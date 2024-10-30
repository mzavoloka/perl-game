
use v5.40;

package game1::object::gun::bullet;

use Data::Dumper;
use game1::color;

use Moose;
extends 'game1::object';


has 'initial_position' => (
    is      => 'rw',
    isa     => 'game1::position',
    #default => sub{ game1->player()->gun() }
);

sub init
{
    my $self = shift;

    $self->view()->color( game1::color->new( name => 'black' ) ); # TODO delete. That's testing

    return;
}

sub fire
{
    my $self = shift;

    $self->move();

    return;
}


1;
