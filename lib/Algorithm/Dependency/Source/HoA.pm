package Algorithm::Dependency::Source::HoA;
# ABSTRACT: Source for a HASH of ARRAYs

=pod

=head1 SYNOPSIS

  # The basic data structure
  my $deps = {
      foo => [ 'bar', 'baz' ],
      bar => [],
      baz => [ 'bar' ],
      };
  
  # Create the source from it
  my $Source = Algorithm::Dependency::Source::HoA->new( $deps );

=head1 DESCRIPTION

C<Algorithm::Dependency::Source::HoA> implements a
L<source|Algorithm::Dependency::Source> where the items names are provided
in the most simple form, a reference to a C<HASH> of C<ARRAY> references.

=head1 METHODS

This documents the methods differing from the ordinary
L<Algorithm::Dependency::Source> methods.

=cut

use 5.005;
use strict;
use Algorithm::Dependency::Source ();
use Params::Util qw{_HASH _ARRAY0};

our $VERSION = '1.113';
our @ISA     = 'Algorithm::Dependency::Source';


#####################################################################
# Constructor

=pod

=head2 new $filename

When constructing a new C<Algorithm::Dependency::Source::HoA> object, an
argument should be provided of a reference to a HASH of ARRAY references,
containing the names of other HASH elements.

Returns the object, or C<undef> if the structure is not correct.

=cut

sub new {
	my $class = shift;
	my $hash  = _HASH(shift) or return undef;
	foreach my $deps ( values %$hash ) {
		_ARRAY0($deps) or return undef;
	}

	# Get the basic source object
	my $self = $class->SUPER::new() or return undef;

	# Add our arguments
	$self->{hash} = $hash;

	$self;
}





#####################################################################
# Private Methods

sub _load_item_list {
	my $self = shift;

	# Build the item objects from the data
	my $hash  = $self->{hash};
	my @items = map {
		Algorithm::Dependency::Item->new( $_, @{$hash->{$_}} )
		or return undef;
		} keys %$hash;

	\@items;
}

1;

=pod

=head1 SEE ALSO

L<Algorithm::Dependency>, L<Algorithm::Dependency::Source>

=cut
