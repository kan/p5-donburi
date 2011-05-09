package Donburi::Web::C::Channel;
use strict;
use warnings;
use parent 'Donburi::Web::C';

use Donburi::Util;

sub do_index {
    my $self = shift;

    return { channels => store() };
}

sub do_add {
    my $self = shift;

    my $store = store();
    my $chan  = $self->req->param('channel');
    unless ( !$chan || grep { $chan eq $_ } @$store ) {
        push @$store, $chan;
        irc()->send_srv("JOIN", $chan);
    }

    return $self->redirect('/channel/');
}

1;
