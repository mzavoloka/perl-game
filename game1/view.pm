
use v5.40;

package game1::view;

use Moose;


has 'symbol'    => ( is => 'rw', isa => 'Str', default => ' ' );

has 'color'     => ( is      => 'rw',
                     isa     => 'game1::color',
                     default => sub{ game1::color -> new( name => 'white' ) } );

has 'invisible' => ( is => 'rw', isa => 'Bool', default => sub{ 1 } );


1;
