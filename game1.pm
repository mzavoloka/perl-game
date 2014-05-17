use v5.18;

package game1;

use Data::Dumper;
use game1::field;
use game1::object;
use game1::position;
use game1::color;
use Time::HiRes qw( time sleep );
use OpenGL qw( :all );
use POSIX qw( floor );

use Moose;


has 'speed' => ( is => 'rw', isa => 'Num', default => 0.5 ); # seconds 

has 'field' => ( is => 'rw', isa => 'game1::field', default => sub{ game1::field -> new() } );


sub go
{
        my $self = shift;
        my $start = time;

        $self -> init();

        while( 1 )
        {
                my $step_time = time;

                $self -> step( $step_time );
                $self -> render();

                $self -> wait_for_the_next_step( $step_time );


        }

        return;
}


sub init 
{
        my $self = shift;

        my $player = game1::object -> new( name     => 'player',
                                           position => game1::position -> new( x => 20,
                                                                               y => 20 ),
                                           view     => game1::view -> new( color => game1::color -> new( name => 'blue' ) ) );

        # my $player_clone = $player -> clone();
        # $player_clone -> name( 'player_clone' );
        # $player_clone -> position( [ game1::position -> new( x => 21,
        #                                                      y => 20 ) ] );
        # my $food_view = game1::view -> new();
        # $food_view -> set_solid_color( 'red' );
        # my $food = game1::object -> new( name     => 'food',
        #                                  position => [ game1::position -> new( x => 19, y => 40 ),
        #                                                game1::position -> new( x => 20, y => 40 ),
        #                                                game1::position -> new( x => 21, y => 40 ) ],
        #                                  view     => $food_view );

        $self -> field() -> objects( [ $player ] );

        glutInit();
        glutCreateWindow( 'window' );
        glutFullScreen();
        glClearColor( 1, 1, 1, 1 );
        glClear( GL_COLOR_BUFFER_BIT );

        glLoadIdentity();
        glViewport( 0, 0, 1920, 1080 );
        glOrtho( 0, glutGet( GLUT_WINDOW_WIDTH ), glutGet( GLUT_WINDOW_HEIGHT ), 0, 0, 1 );

        return;
}


sub step
{
        my ( $self, $step_time ) = @_;

        my $random_direction = { 1 => 'left',
                                 2 => 'right',
                                 3 => 'up', 
                                 4 => 'down' };

        my $direction = 'move_' . $random_direction -> { floor( rand( 4 ) + 1 ) };
        $self -> field() -> get_object_by_name( 'player' ) -> $direction();
        
        return;
}


sub render
{
        my $self = shift;

	for( my $h = 0; $h < $self -> field() -> height(); $h ++ )
        {
                for( my $w = 0; $w < $self -> field() -> width(); $w ++ )
		{
                        glColor3f( 0, 1, 1 );

                        glBegin( GL_LINE_STRIP );
                          glVertex2f(   $w       * $self -> field() -> cell_width(),   $h       * $self -> field() -> cell_height() );
                          glVertex2f( ( $w + 1 ) * $self -> field() -> cell_width(),   $h       * $self -> field() -> cell_height() );
                          glVertex2f( ( $w + 1 ) * $self -> field() -> cell_width(), ( $h + 1 ) * $self -> field() -> cell_height() );
                          glVertex2f(   $w       * $self -> field() -> cell_width(), ( $h + 1 ) * $self -> field() -> cell_height() );
                          glVertex2f(   $w       * $self -> field() -> cell_width(),   $h       * $self -> field() -> cell_height() );
                        glEnd();

                        if( my $object = $self -> field() -> get_object_on_cell( $w, $h ) )
                        {
                                glColor3f( $object -> view() -> color() -> get_rgb() );

                                glBegin( GL_POLYGON );
                                  glVertex2f(   $w       * $self -> field() -> cell_width()     ,   $h       * $self -> field() -> cell_height() + 1 );
                                  glVertex2f( ( $w + 1 ) * $self -> field() -> cell_width() - 1 ,   $h       * $self -> field() -> cell_height() + 1 );
                                  glVertex2f( ( $w + 1 ) * $self -> field() -> cell_width() - 1 , ( $h + 1 ) * $self -> field() -> cell_height()     );
                                  glVertex2f(   $w       * $self -> field() -> cell_width()     , ( $h + 1 ) * $self -> field() -> cell_height()     );
                                glEnd();
                        }
                        else
                        {
                                glColor3f( 1, 1, 1 );

                                glBegin( GL_POLYGON );
                                  glVertex2f(   $w       * $self -> field() -> cell_width()     ,   $h       * $self -> field() -> cell_height() + 1 );
                                  glVertex2f( ( $w + 1 ) * $self -> field() -> cell_width() - 1 ,   $h       * $self -> field() -> cell_height() + 1 );
                                  glVertex2f( ( $w + 1 ) * $self -> field() -> cell_width() - 1 , ( $h + 1 ) * $self -> field() -> cell_height()     );
                                  glVertex2f(   $w       * $self -> field() -> cell_width()     , ( $h + 1 ) * $self -> field() -> cell_height()     );
                                glEnd();
                        }
		}
	}

        glFlush();

        return;
}

sub wait_for_the_next_step
{
        my ( $self, $step_time ) = @_;

        my $next_step_time = $step_time + $self -> speed();
        # say "Next step time: $next_step_time";

        if( time <= $next_step_time )
        {
                my $time_until_next_step = $next_step_time - time();
                #say "Time until next step: $time_until_next_step";
                sleep( $time_until_next_step );
        }

        return;
}


sub hd_resolutions
{
	say "Possible HD Resolutions:";
	say;

	my $aspect = { width  => 16,
		       height => 9 };

	for( my $i = 1; $i < 10; $i ++ )
	{
		say sprintf( "%d x %d",
                             $aspect -> { 'width' }  * $i,
                             $aspect -> { 'height' } * $i );
	}

	say "That seems more than enough. Choose one for your game field.";
}


1;
