package Donburi::Web::C::Root;
use strict;
use warnings;
use parent 'Donburi::Web::C';

use Donburi::Util;

sub do_index {
    my $self = shift;

    return;
}

sub do_post {
    my $self = shift;

    irc()->send_chan('#kan', 'NOTICE', '#kan', $self->req->param('message'));

    return;
}

1;
