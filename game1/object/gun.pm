
use v5.40;

package game1::object::gun;

use Data::Dumper;
use game1;

use Moose;
extends 'game1::object';

has 'bullet'    => ( is      => 'rw',
                     isa     => 'game1::object::gun::bullet',
                     default => sub{ game1::gun -> new() } );

has 'weight_kg' => ( is      => 'rw',
                     isa     => 'Number',
                     default => sub{ 1.105 } );

has 'damage'    => ( is      => 'rw',
                     isa     => 'Int',
                     default => sub{ 100 } ); # Create damage object that will have random damage in certain range


sub init
{
        my $self = shift;
        
        $self -> view() -> color( 'black' ); # TODO delete. That's testing
        $self -> view() -> invisible( 0 );

        $self -> position( game1 -> player() -> position() );

        return;
}


1;
