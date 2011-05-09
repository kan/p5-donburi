package Donburi::Util;
use strict;
use warnings;
use Exporter 'import';
our @EXPORT = qw(conf irc xslate store);

use Scope::Container;

sub conf { scope_container('config') }

sub irc { scope_container('irc') }

sub xslate { scope_container('xslate') }

sub store { scope_container('store') }

1;
