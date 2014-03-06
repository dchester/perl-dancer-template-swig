package Dancer::Template::Swig;

use strict;
use warnings;

use Carp qw(confess);

use Dancer::Config 'setting';

use Template::Swig;

use Dancer::FileUtils 'read_file_content';
use Dancer::Exception qw(:all);

use base 'Dancer::Template::Abstract';

my $views_path = setting('views');

our $swig = Template::Swig->new(
	template_dir => $views_path,
	extends_callback => sub {
		my ($filename, $encoding) = @_;
		if ( -e $filename ) {
			my $template = read_file_content($filename);
			$template =~ /(.*)/s; # Untaint
			return $1;
		} else {
			die "Unable to locate $filename";
		}
	}
);

sub init {

	my $views_path = setting('views');

	opendir my $dh, $views_path || die "couldn't open views directory";

	while (my $filename = readdir $dh) {

		next if $filename =~ /^\.\.?$/;

		my $source = read_file_content join '/', $views_path, $filename;
		(my $name = $filename) =~ s/$views_path\/?//g;

		$swig->compile($name, $source);
	}

	return 1;
}

sub render {

	my ($self, $filename, $tokens) = @_;
	my $views_path = setting('views');

	if (ref $filename) {
		confess "passing a reference not yet supported";
	}

	(my $name = $filename) =~ s/$views_path\/?//g;
	my $output = $swig->render($name, $tokens);

	return $output;
}

1;

=pod

=head1 NAME

Dancer::Template::Swig - Django-inspired Swig templating for Dancer

=head1 DESCRIPTION

In config.yml, set the templating engine:

    template: swig

In your application setup, load swig and disable Dancer layouts in favor of Swig inheritance:

    set layout => undef;

=head1 SEE ALSO

L<Template::Swig>, L<Dancer::Template::Abstract>, L<Dancer>

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2012, David Chester

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=cut

