use inc::Module::Install;
use Module::Install::AuthorTests;

name 'Donburi';
all_from 'lib/Donburi.pm';
install_script 'donburi';

requires 'parent';
requires 'Exporter' => 5.36;
requires 'Plack::Request';
requires 'AnyEvent';
requires 'AnyEvent::IRC::Client';
requires 'String::CamelCase';
requires 'Scope::Container';
requires 'Router::Simple';
requires 'YAML::Syck';
requires 'Text::Xslate';
requires 'Twiggy::Server';
requires 'Class::Accessor::Lite' => 0.04;
requires 'Class::Load';
requires 'JSON';


tests 't/*.t t/*/*.t t/*/*/*.t t/*/*/*/*.t';
test_requires 'Test::More' => 0.96; # done_testing, subtest
# test_requires 'Test::Requires';
author_tests('xt');
WriteAll;
