
use v5.40;

package game1::color;

use Color::Rgb;

use Moose;


has 'name' => (
    is  => 'rw',
    isa => 'Maybe[Str]'
);

has 'r' => (
    is      => 'rw',
    isa     => 'Int',
    default => 0
);

has 'g' => (
    is      => 'rw',
    isa     => 'Int',
    default => 0
);

has 'b' => (
    is      => 'rw',
    isa     => 'Int',
    default => 0
);

has 'a' => (
    is      => 'rw',
    isa     => 'Int',
    default => 1
);

use constant {
    #COLOR => Color::Rgb -> new( rgb_txt => '/etc/X11/rgb.txt' )
    COLOR => Color::Rgb -> new( rgb_txt => '/usr/share/imlib2/rgb.txt' )
};


sub BUILD
{
    my ( $self, $args ) = @_;

    if( $self -> name() )
    {
        $self -> set_color( COLOR -> rgb( $self -> name() ) );
    }
    # if( $self -> name() eq 'black' )
    # {
    #         $self -> set_color( 1, 1, 1, 1 );
    # }
    # elsif( $self -> name() eq 'red' )
    # {
    #         $self -> set_color( 1, 0, 0, 1 );
    # }
    # elsif( $self -> name() eq 'green' )
    # {
    #         $self -> set_color( 0, 1, 0, 1 );
    # }
    # elsif( $self -> name() eq 'blue' )
    # {
    #         $self -> set_color( 0, 0, 1, 1 );
    # }

    return;
}

sub set_color
{
    my ( $self, $r, $g, $b, $a ) = @_;

    $self -> r( $r );
    $self -> g( $g );
    $self -> b( $b );
    $self -> a( $a ) if $a;

    return;
}

sub get_rgb
{
    my $self = shift;

    return( $self -> r(), $self -> g(), $self -> b() );
}

sub get_rgba
{
    my $self = shift;

    return( $self -> get_rgb(), $self -> a() );
}

1;
