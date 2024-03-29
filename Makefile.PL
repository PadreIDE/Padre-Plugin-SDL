use inc::Module::Install;

name     'Padre-Plugin-SDL';
all_from 'lib/Padre/Plugin/SDL.pm';
author   'Gabor Szabo <szabgab@gmail.com>';
license  'perl';

requires  'Padre'         => '0.43';
requires  'SDL'           => '2.511'; # '2.2.0';

build_requires 'Test::More';

no_index   'directory' => qw{ t xt eg share inc privinc };
homepage   'http://padre.perlide.org/';
bugtracker 'http://padre.perlide.org/trac/';
repository 'https://github.com/PadreIDE/Padre-Plugin-SDL/';

is_padre_plugin; # authors: Install Module::Install::PadrePlugin
auto_install;
#install_share_with_mofiles;
install_share;

install_script 'padre_logoish';

WriteAll;

