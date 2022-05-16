package Thruk::Controller::test;

use warnings;
use strict;

use Thruk::Action::AddDefaults ();
use Thruk::Backend::Pool ();

=head1 NAME

Thruk::Controller::test - Thruk Controller

=head1 DESCRIPTION

Thruk Controller.

=head1 METHODS

=cut

=head2 index

=cut

##########################################################
sub index {
    my ( $c ) = @_;

    if(Thruk::Base->mode ne 'TEST_LEAK' && Thruk::Base->mode ne 'TEST' && !Thruk::Base->debug) {
        die("test.cgi is disabled unless in test mode!");
    }

    return unless Thruk::Action::AddDefaults::add_defaults($c, Thruk::Constants::ADD_DEFAULTS);

    $c->stash->{'template'}            = 'main.tt';
    $c->stash->{'allowed_frame_links'} = [];

    my $action = $c->req->parameters->{'action'} || '';

    if($action eq 'leak') {
        my $leak = Thruk::Backend::Pool->new();
        $leak->{'test'} = $leak;
        $c->stash->{ctx} = $c;
    }

    return 1;
}

1;
