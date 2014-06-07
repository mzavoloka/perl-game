
use v5.18;

package game1::object;

use Data::Dumper;
use game1::position;
use game1::view;

use Moose;
with 'MooseX::Clone';


has 'name'     => ( is      => 'rw',
                    isa     => 'Str',
                    default => sub{ 'Incognito' } );

has 'position' => ( is      => 'rw',
                    isa     => 'game1::position',
                    default => sub{ game1::position -> new( x => 0, y => 0 ) } );

has 'desitination' => ( is      => 'rw',
                        isa     => 'Maybe[game1::position]',
                        default => sub{ undef } );

has 'velocity' => ( is      => 'rw',
                    isa     => 'Number',
                    default => 0 );

has 'health'   => ( is      => 'rw',
                    isa     => 'Int',
                    default => 100 );

has 'size'     => ( is      => 'rw',
                    isa     => 'HashRef',
                    default => sub{ { width  => 10,
                                      height => 10 } } );

has 'view'     => ( is      => 'rw',
                    isa     => 'game1::view',
                    default => sub{ game1::view -> new() } );


sub move_left
{
        my $self = shift;

        $self -> position() -> x( $self -> position() -> x() - 1 );

        return;
}

sub move_right
{
        my $self = shift;

        $self -> position() -> x( $self -> position() -> x() + 1 );

        return;
}

sub move_up
{
        my $self = shift;

        $self -> position() -> y( $self -> position() -> y() - 1 );

        return;
}

sub move_down
{
        my $self = shift;

        $self -> position() -> y( $self -> position() -> y() + 1 );

        return;
}


1;
