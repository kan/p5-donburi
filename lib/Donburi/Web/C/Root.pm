package Donburi::Web::C::Root;
use strict;
use warnings;
use parent 'Donburi::Web::C';

use Donburi::Util;

sub do_index {
    my $self = shift;

    return { channels => store() };
}

sub do_post {
    my $self = shift;

    my $chan = $self->req->param('channel');
    irc()->send_chan($chan, 'NOTICE', $chan, $self->req->param('message'));

    return;
}

1;
