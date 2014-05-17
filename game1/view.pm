
use v5.18;

package game1::view;

use Moose;


has 'symbol' => ( is => 'rw', isa => 'Str', default => ' ' );

has 'color' => ( is      => 'rw',
                 isa     => 'game1::color',
                 default => sub{ game1::color -> new( name => 'white' ) } );


1;
