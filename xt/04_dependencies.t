use ExtUtils::MakeMaker;
use Test::Dependencies
    exclude => [qw/Test::Dependencies Donburi/],
    style   => 'light' ;

ok_dependencies();
