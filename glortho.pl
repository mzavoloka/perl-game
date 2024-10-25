use v5.40;

package game1;

use Data::Dumper;
use OpenGL qw( :all );

use Moose;

glutInit();
glutCreateWindow( 'window' );
glutFullScreen();
glClearColor( 1, 1, 1, 1 );
glClear( GL_COLOR_BUFFER_BIT );
glLoadIdentity();
#glOrtho( -100, 100, -100, 100, -100, 100 );
glViewport( 0, 0, 1920, 1080 );
glOrtho( 0, glutGet( GLUT_WINDOW_WIDTH ), glutGet( GLUT_WINDOW_HEIGHT ), 0, 0, 1 );

glColor3f( 0, 1, 1 );

while( 1 )
{
        glBegin( GL_POLYGON );
          glVertex2f( 0, 0 );
          glVertex2f( 0, glutGet( GLUT_WINDOW_HEIGHT ) );
          glVertex2f( glutGet( GLUT_WINDOW_WIDTH ), 0 );
        glEnd();

        glFlush();
}

#for( my $i = -100; $i <= 100; $i += 100 )
#{
#        if( $i <= 0 )
#        {
#                glColor3f( 0, 1, 1 );
#        }
#        else
#        {
#                glColor3f( 1, 0, 1 );
#        }
#
#        glBegin( GL_POLYGON );
#          glVertex2f( $i, $i + 100 );
#          glVertex2f( $i, $i );
#          glVertex2f( $i + 100, $i );
#        glEnd();
#}

# glutMainLoop();

