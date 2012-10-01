#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Dancer::Template::Swig' ) || print "Bail out!\n";
}

diag( "Testing Dancer::Template::Swig $Dancer::Template::Swig::VERSION, Perl $], $^X" );
