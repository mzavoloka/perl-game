use v5.18;

package game1;

use Data::Dumper;
use game1::field;
use game1::object;
use game1::position;
use game1::color;
use game1::const qw( RESOLUTION );
use Time::HiRes qw( time sleep );
use OpenGL qw( :all );
use SDL;
use POSIX qw( floor );

use Moose;


has 'speed' => ( is => 'rw', isa => 'Num', default => sub{ 1 / 60 } ); # seconds ( 60 FPS )

has 'field' => ( is => 'rw', isa => 'game1::field', default => sub{ game1::field -> new() } );


sub go
{
        my $self = shift;
        my $start = time;

        $self -> init();

        glutMainLoop();

        die 'outside of main loop';

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

        $self -> field() -> objects( [ $player ] );

        glutInit();
        glutInitWindowSize( RESOLUTION -> { 'width' }, RESOLUTION -> { 'height' } );
        glutInitWindowPosition( 1800 - RESOLUTION -> { 'width' }, 100 );
        glutCreateWindow( 'game1' );

        glClearColor( 1, 1, 1, 1 );
        glClear( GL_COLOR_BUFFER_BIT );

        glLoadIdentity();
        #glViewport( 0, 0, 1920, 1080 );
        glOrtho( 0, glutGet( GLUT_WINDOW_WIDTH ), glutGet( GLUT_WINDOW_HEIGHT ), 0, 0, 1 );


        glutKeyboardFunc( sub{ $self -> keydown_handler( @_ ) } );
        glutKeyboardUpFunc( sub{ $self -> keyup_handler( @_ ) } );
        #glutDisplayFunc( sub{ $self -> render( @_ ) } );

        glutSpecialFunc( sub{ $self -> keyspecial_handler( @_ ) } );

        glutIdleFunc( sub{ $self -> step( @_ ) } );

        return;
}

{
        sub keydown_handler
        {
                my ( $self, $key, $mouse_x, $mouse_y ) = @_;
        
                if( $key == 113 ) # q
                {
                        glutLeaveMainLoop();
                }

                if( $key == 32 )
                {
                        say 'space!!!';
                        $self -> player() -> gun() -> fire();
                }

                say $key;
        
                return;
        }
        
        sub keyup_handler
        {
                my ( $self, $key, $mouse_x, $mouse_y ) = @_;
        
        
        
                return;
        }
                
        sub keyspecial_handler
        {
                my ( $self, $key, $mouse_x, $mouse_y ) = @_;
        
                if( $key == GLUT_KEY_UP )
                {
                        $self -> player() -> move_up();
                }
                elsif( $key == GLUT_KEY_DOWN )
                {
                        $self -> player() -> move_down();
                }
                elsif( $key == GLUT_KEY_LEFT )
                {
                        $self -> player() -> move_left();
                }
                elsif( $key == GLUT_KEY_RIGHT )
                {
                        $self -> player() -> move_right();
                }
        
                return;
        }
}

{
        my $step_time;

        sub step
        {
                my $self = shift;
        
                $step_time = time();
                #$self -> move_player_in_random_direction();

                $self -> move_ovbjects_that_have_velocity();

                $self -> render();
                $self -> wait_for_the_next_step( $step_time );

                return;
        }
}

sub move_ovbjects_that_have_velocity
{
        my $self = shift;

        foreach my $object ( @{ $self -> field() -> objects() } )
        {
                if( $object -> velocity()
                    and
                    $object -> destination() )
                {
                        $object -> destination();
                }
        }

        return;
}

sub move_player_in_random_direction
{
        my $self = shift;

        my $random_direction = { 1 => 'left',
                                 2 => 'right',
                                 3 => 'up', 
                                 4 => 'down' };

        my $direction = 'move_' . $random_direction -> { floor( rand( 4 ) + 1 ) };
        $self -> player() -> $direction();

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

        #glutPostRedisplay();

        return;
}

sub wait_for_the_next_step
{
        my ( $self, $step_time ) = @_;

        my $next_step_time = $step_time + $self -> speed();

        if( ( my $time_until_next_step = $next_step_time - time() ) > 0 )
        {
                sleep( $time_until_next_step );
        }

        return;
}

sub player
{
        my $self = shift;

        return $self -> field() -> get_object_by_name( 'player' );
}


1;
