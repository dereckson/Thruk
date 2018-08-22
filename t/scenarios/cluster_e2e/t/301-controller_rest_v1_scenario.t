use strict;
use warnings;
use Test::More;

die("*** ERROR: this test is meant to be run with PLACK_TEST_EXTERNALSERVER_URI set") unless defined $ENV{'PLACK_TEST_EXTERNALSERVER_URI'};

BEGIN {
    plan tests => 7;

    use lib('t');
    require TestUtils;
    import TestUtils;
    $ENV{'NO_POST_TOKEN'} = 1; # disable adding "token" to each POST request
}

use_ok 'Thruk::Controller::rest_v1';

my $pages = [{
        url          => '/csv/services?q=***description ~ http and description !~ cert***&columns=description',
        like         => ['Https'],
        unlike       => ['Cert'],
        content_type => 'text/plain; charset=UTF-8',
    },
];

for my $test (@{$pages}) {
    $test->{'content_type'} = 'application/json;charset=UTF-8' unless $test->{'content_type'};
    $test->{'url'}          = '/thruk/r'.$test->{'url'};
    my $page = TestUtils::test_page(%{$test});
    #BAIL_OUT("failed") unless Test::More->builder->is_passing;
}
