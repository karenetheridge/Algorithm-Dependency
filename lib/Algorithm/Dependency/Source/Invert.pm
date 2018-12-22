package Algorithm::Dependency::Source::Invert;
# ABSTRACT: Logically invert a source

=pod

=head1 SYNOPSIS

  my $inverted = Algorithm::Dependency::Source::Invert->new( $source );

=head1 DESCRIPTION

This class creates a source from another source, but with all dependencies
reversed.

=cut

use 5.005;
use strict;
use Params::Util '_INSTANCE';
use Algorithm::Dependency::Source::HoA ();

our $VERSION = '1.112';
our @ISA     = 'Algorithm::Dependency::Source::HoA';


#####################################################################
# Constructor

sub new {
	my $class  = shift;
	my $source = _INSTANCE(shift, 'Algorithm::Dependency::Source') or return undef;

	# Derive a HoA from the original source
	my @items = $source->items;
	my %hoa   = map { $_->id => [ ] } @items;
	foreach my $item ( @items ) {
		my $id   = $item->id;
		my @deps = $item->depends;
		foreach my $dep ( @deps ) {
			push @{ $hoa{$dep} }, $id;
		}
	}

	# Hand off to the parent class
	$class->SUPER::new( \%hoa );
}

1;

=pod

=head1 SEE ALSO

L<Algorithm::Dependency::Source>, L<Algorithm::Dependency::Source::HoA>

=cut
