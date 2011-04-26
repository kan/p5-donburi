package Donburi::Dispatcher;
use strict;
use warnings;

use Router::Simple;
use Plack::Request;
use Class::Load qw/load_class/;

sub new {
    my $class = shift;

    my $router = Router::Simple->new();
    $router->connect('/', { controller => 'Root', action => 'index' });
    $router->connect('/post', { controller => 'Root', action => 'post' });

    return bless { router => $router }, $class;
}

sub dispatch {
    my ($self, $env) = @_;
    
    if ( my $p = $self->{router}->match($env) ) {
        my $c = "Donburi::Web::C::" . $p->{controller};
        my $action = 'do_' . $p->{action};
        load_class($c);
        my $req = Plack::Request->new($env);
        my $ci = $c->new(req => $req);
        my $res = $ci->$action;
        return $res && ref($res) eq 'ARRAY' ? $res : $ci->auto_render($p->{action}, $res);
    } else {
        return [ 404, [], ['not found'] ];
    }
}

1;
