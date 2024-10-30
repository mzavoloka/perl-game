
use v5.40;

package game1::field;

use game1::const qw( RESOLUTION );
use Data::Dumper;

use Moose;


has 'objects' => (
    traits  => [ 'Array' ],
    is      => 'rw',
    isa     => 'ArrayRef[ game1::object ]',
    default => sub{ [] },
    handles => { add => 'push', all => 'elements' },
);

has 'width'   => ( is => 'ro', isa => 'Int', default => sub{ RESOLUTION -> { 'width' } / 20 } );

has 'height'  => ( is => 'ro', isa => 'Int', default => sub{ RESOLUTION -> { 'height' } / 20 } );

has 'cell_width'  => ( is => 'rw', isa => 'Int', default => 0 );

has 'cell_height' => ( is => 'rw', isa => 'Int', default => 0 );

sub BUILD
{
    my $self = shift;

    $self -> cell_width( RESOLUTION -> { 'width' } / $self -> width() );
    $self -> cell_height( RESOLUTION -> { 'height' } / $self -> height() );

    return;
}

sub get_object
{
    my ( $self, $object_name ) = @_;

    foreach my $object ( @{ $self -> objects() } )
    {
        if( $object -> name() eq $object_name )
        {
            return $object;
        }
    }

    die 'No object with such name!';

    return;
}

sub get_object_on_cell
{
    my ( $self, $w, $h ) = @_;

    foreach my $object ( @{ $self -> objects() } )
    {
        if( $object -> position() -> x() == $w
                and
            $object -> position() -> y() == $h )
        {
            return $object;
        }
    }

    return;
}

sub get_object_by_name
{
    my ( $self, $name ) = @_;

    my @objects_with_such_name = grep { $_ -> name() eq $name } @{ $self -> objects() };

    return( @objects_with_such_name ? $objects_with_such_name[ 0 ] : undef );
}


1;
