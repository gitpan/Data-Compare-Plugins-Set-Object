use inc::Module::Install;

name     'Data-Compare-Plugins-Set-Object';
author   q{Mark Gardner <mjgardner@cpan.org>};
version  '1.0_2';
license  'perl';
all_from 'lib/Data/Compare/Plugins/Set/Object.pm';

build_requires 'Test::More';

configure_requires 'version' => '0.77';

requires 'Data::Compare' => '0.06';
requires 'List::MoreUtils' => '0.04';
requires 'English' => 0;

#auto_install;

WriteAll;

