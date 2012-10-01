use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Dancer::Template::Swig',
    AUTHOR              => q{David Chester <david@fmail.co.uk>},
    VERSION_FROM        => 'lib/Dancer/Template/Swig.pm',
    ABSTRACT_FROM       => 'lib/Dancer/Template/Swig.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Dancer-Template-Swig-*' },
);
