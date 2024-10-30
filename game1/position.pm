
use v5.40;

package game1::position;

use Moose;

has 'x' => ( is => 'rw', isa => 'Int', default => 0 );

has 'y' => ( is => 'rw', isa => 'Int', default => 0 );

sub set
{
    my ( $self, $x, $y ) = shift;

    $self->x( $x );
    $self->y( $y );

    return;
}


1;
