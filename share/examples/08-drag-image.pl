use strict;
use warnings;

use SDL;
use SDL::Constants;
use SDL::App;
use File::Basename        qw(dirname);
use File::Spec::Functions qw(catfile);

# after launching this script try to grab the blue butterfly with your mouse
# and drag it around the board

my $board_width = 640;
my $board_height = 480;


my $img16 = catfile(dirname($0), 'img', 'padre_logo_16x16.png');
my $img64 = catfile(dirname($0), 'img', 'padre_logo_64x64.png');
my $frame = SDL::Surface->new( -name => $img64 );

my $x = int( ($board_width  - $frame->width) /2);
my $y = int( ($board_height - $frame->height) /2);


my $window = SDL::App->new(
	-width => $board_width,
	-height => $board_height,
	-depth => 16,
	-title => 'SDL Demo',
);


my $frame_rect = SDL::Rect->new(
        -height => $frame->height(),
        -width  => $frame->width(),
        -x      => 0,
        -y      => 0,
);
my $rect  = SDL::Rect->new(
        -height => $frame->height(),
        -width  => $frame->width(),
        -x      => $x,
        -y      => $y,
);


dd();

my $event = SDL::Event->new;

my $grab = 0;
while (1) {
	while ($event->poll) {
		my $type = $event->type;
		exit if ($type == SDL_QUIT());
		exit if ($type == SDL_KEYDOWN() && $event->key_name eq 'escape');
		if ( $type == SDL_MOUSEBUTTONDOWN()) {
			print "Mouse down\n";
			printf("Sprite (%s, %s) width %s height %s\n", $rect->x(), $rect->y(), $rect->width, $rect->height);
			printf("Button     (%s, %s)\n", $event->button_x, $event->button_y);
			if ($rect->x < $event->button_x and
				$event->button_x < $rect->x + $rect->width and
				$rect->y < $event->button_y and
				$event->button_y < $rect->y + $rect->height) {
				# on the object
				$grab = 1;
				print "Grab !!!\n";
			}
		} elsif ( $type == SDL_MOUSEBUTTONUP()) {
			$grab = 0;
			print "Mouse up\n";
		} elsif ( $type == SDL_MOUSEMOTION()) {
			#printf("Motion     (%s, %s)\n", $event->motion_x, $event->motion_y);  # absolute locations
			#printf("Motion rel (%s, %s)\n", $event->motion_xrel, $event->motion_yrel); # how much was the mouse moved
			#printf("Button     (%s, %s)\n", $event->button_x, $event->button_y); # seems to be the same as motion_x
			if ($grab) {
				#print "Mouse moves $event\n";
				#print "Mx ", $event->motion_x, "\n";
				$rect->x($rect->x + $event->motion_xrel);
				$rect->y($rect->y + $event->motion_yrel);
				dd();
			}
		}
	}
}

sub dd {
	$frame->blit( $frame_rect, $window, $rect );
	$window->update( $rect );
}

