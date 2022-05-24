use warnings;
use strict;
use Test::More;
use utf8;

BEGIN {
    use lib('t');
    require TestUtils;
    import TestUtils;
    plan tests => 58;
}

###############################################################################
TestUtils::test_page(
    'url'   => '/thruk/cgi-bin/login.cgi?logout',
    'like'  => ['Login with OAuth'],
    'code'  => 401,
    'follow'  => 1,
);

###############################################################################
TestUtils::test_page(
    'url'   => '/thruk/cgi-bin/login.cgi',
    'like'  => ['Login with OAuth'],
    'code'  => 401,
);

###############################################################################
TestUtils::test_page(
    'url'     => '/thruk/cgi-bin/login.cgi',
    'post'    => { 'oauth' => 0, submit => 'login' },
    'like'    => ['tac.cgi'],
    'follow'  => 1,
);

###############################################################################
TestUtils::test_page(
    'url'     => '/thruk/cgi-bin/tac.cgi',
    'like'    => ['>User<.*?>clientö<'],
);

###############################################################################
TestUtils::test_page(
    'url'   => '/thruk/cgi-bin/login.cgi?logout',
    'like'  => ['Login with OAuth'],
    'code'  => 401,
    'follow'  => 1,
);
