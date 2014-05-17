
use v5.18;

package game1::const;

use base 'Exporter';

use constant {
        RESOLUTION => { width  => 800,
                        height => 600 },
};

our @EXPORT_OK = qw(
        RESOLUTION
);

1;
