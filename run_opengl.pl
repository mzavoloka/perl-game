
# BEGIN{ unshift(@INC,"../blib");} # in case OpenGL is built but not installed
use OpenGL qw( :old );

glpOpenWindow;
glClearColor(0,0,1,1);
glClear(GL_COLOR_BUFFER_BIT);
glLoadIdentity;
glOrtho(-1,1,-1,1,-1,1);

glColor3f(0,0,1);
glBegin(GL_POLYGON);
glVertex2f(-0.5,-0.5);
glVertex2f(-0.5, 0.5);
glVertex2f( 0.5, 0.5);
glVertex2f( 0.5,-0.5);
glEnd();

glColor3f(1,1,0);
glBegin(GL_POLYGON);
glVertex2f(-0.5, 0.5);
glVertex2f( 0.5, 0.5);
glVertex2f( 0.5,-0.5);
glEnd();

glFlush();

print "Program 1-1 Simple, hit control-D to quit:\n\n";
while(<>){;}

