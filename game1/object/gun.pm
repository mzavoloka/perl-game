
use v5.40;

package game1::object::gun;

use Data::Dumper;
use game1::object::gun::bullet;
use game1::color;

use Moose;
extends 'game1::object';

has 'bullet'    => (
    is      => 'rw',
    isa     => 'game1::object::gun::bullet',
    default => sub{ game1::object::gun::bullet->new() }
);

has 'weight_kg' => (
    is      => 'rw',
    isa     => 'Num',
    default => sub{ 1.105 }
);

has 'damage'    => (
    is      => 'rw',
    isa     => 'Int',
    default => sub{ 100 }
); # Create damage object that will have random damage in certain range


sub BUILD
{
    my $self = shift;

    $self->view()->color( game1::color->new( name => 'black' ) ); # TODO delete. That's testing
    #$self->view()->invisible( 0 );

    #$self->position( game1->player()->position() );

    return;
}

sub fire
{
    my $self = shift;

    $self->move_up();
    say 'moving';

    return;
}

1;
