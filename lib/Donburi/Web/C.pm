package Donburi::Web::C;
use strict;
use warnings;

use Donburi::Util;
use String::CamelCase qw/decamelize/;

use Class::Accessor::Lite (
    new => 1,
    ro  => [qw/req/],
);

use Text::Xslate;

our $tx;

sub render {
    my ($self, $tmpl, $vars) = @_;
    $vars ||= {};

    my $content = xslate()->render($tmpl, $vars);

    return [
        200,
        [   'Content-Type'   => 'text/html',
            'Content-Length' => length($content)
        ],
        [$content]
    ];
}

sub auto_render {
    my ( $self, $action, $vars ) = @_;

    ( my $class = ref($self) ) =~ s/^Donburi::Web::C:://;
    my $tmpl = join( '/',
        conf()->{tmpl_path},
        map { decamelize($_) } split( '::', $class ) );

    return $self->render("$tmpl/$action.tx", $vars);
}

sub redirect {
    my ( $self, $path ) = @_;

    return [ 301, ['Location' => $path ], [''] ];
}

1;
