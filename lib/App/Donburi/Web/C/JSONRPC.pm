package App::Donburi::Web::C::JSONRPC;
use strict;
use warnings;

use parent 'App::Donburi::Web::C';

use JSON;

use App::Donburi::Util;
use MIME::Base64;

sub do_call {
    my $self = shift;
    my $method = $self->req->param('method');
    my $query  = $self->req->param('params');
    my $params;
    eval{
        $params = JSON->new->utf8(0)->decode($query);
    };
    if ( $@ ) {
        $params = JSON->new->utf8(0)->decode(decode_base64($query));
    }

    my $text = $params->{text};
    my $channel = $params->{channel};
    unless (
        $method eq 'channels'
        || defined $text && defined $channel && grep /^$method$/,
        qw( privmsg notice )
      )
    {
        #TODO Handle error?
        return [
            500,
            [ 'Content-Type' => 'application/json' ],
            [ JSON->new->utf8->encode({ message => 'internal server error', code => 000 }) ]
        ];
    }

    my $body;
    if( $method eq 'channels' ) {
        $body = store();
    } else {
        my $mode = uc $method;
        my @line = split /[\r\n]+/, $text;
        for my $msg ( @line ) {
            send_chan($channel, $mode, $channel, $msg);
        }
        $body = 'ok';
    }

    return [
        200,
        [ 'Content-Type' => 'application/json' ],
        [ JSON->new->utf8->encode( { json_rpc => "2.0", result => $body } ) ]
    ];
}

1;
