package Algorithm::Dependency::Item;

=pod

=head1 NAME

Algorithm::Dependency::Item - Implements an item in a dependency hierarchy.

=head1 DESCRIPTION

The Algorithm::Dependency::Item class implements a single item within the
dependency hierarchy. It's quite simple, usually created from within a source,
and not typically created directly. This is provided for those implementing
their own source. ( See L<Algorithm::Dependency::Source> for details ).

=head1 METHODS

=cut

use 5.005;
use strict;
use Algorithm::Dependency ();

our $VERSION = '1.111';


#####################################################################
# Constructor

=pod

=head2 new $id, @depends

The C<new> constructor takes as its first argument the id ( name ) of the
item, and any further arguments are assumed to be the ids of other items that
this one depends on.

Returns a new C<Algorithm::Dependency::Item> on success, or C<undef>
on error.

=cut

sub new {
	my $class = shift;
	my $id    = (defined $_[0] and ! ref $_[0] and $_[0] ne '') ? shift : return undef;
	bless { id => $id, depends => [ @_ ] }, $class;
}

=pod

=head2 id

The C<id> method returns the id of the item.

=cut

sub id { $_[0]->{id} }

=pod

=head2 depends

The C<depends> method returns, as a list, the names of the other items that
this item depends on.

=cut

sub depends { @{$_[0]->{depends}} }

1;

=pod

=head1 SUPPORT

For general comments, contact the author.

To file a bug against this module, in a way you can keep track of, see the
CPAN bug tracking system.

L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Algorithm-Dependency>

=head1 AUTHOR

Adam Kennedy E<lt>adamk@cpan.orgE<gt>

=head1 SEE ALSO

L<Algorithm::Dependency>

=head1 COPYRIGHT

Copyright 2003 - 2009 Adam Kennedy.

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

=cut
