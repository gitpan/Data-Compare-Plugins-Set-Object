package Data::Compare::Plugins::Set::Object;

use strict;
use warnings;
use version 0.77; our $VERSION = qv('v1.0_2');
use English qw(-no_match_vars);
use Data::Compare;
use List::MoreUtils qw(any);

sub _register {
    return [ 'Set::Object', \&_so_set_compare ];
}

sub _so_set_compare {
    my @set = splice @ARG, 0, 2;

    return 0 if $set[0]->size != $set[1]->size;
    return 1 if $set[0] == $set[1];

    my $count = 0;
    for my $element ( $set[0]->elements ) {
        return 0
          if not any { Data::Compare::Compare( $element, $ARG ) }
            grep { ref eq ref $element } $set[1]->elements;
        $count++;
    }
    return $count == $set[0]->size;
}

_register();

__END__

=head1 NAME

Data::Compare::Plugins::Set::Object - plugin for Data::Compare to handle
Set::Object objects

=head1 VERSION

This document describes Data::Compare::Plugins::Set::Object version 1.0_2

=head1 SYNOPSIS

    use Set::Object 'set';
    use Data::Compare;

    my $foo = {
        list => [ qw(one two three) ],
        set  => set( [1], [2], [3] ),
    };
    my $bar = {
        list => [ qw(one two three) ],
        set  => set( [1], [2], [3] ),
    };

    say 'Sets in $foo and $bar are ',
        $foo->{set} == $bar->{set} ? '' : 'NOT ', 'identical.';
    say 'Data within $foo and $bar are ',
        Compare($foo, $bar) ? '' : 'NOT ', 'equal.';

=head1 DESCRIPTION

Enables L<Data::Compare> to Do The Right Thing for L<Set::Object> objects.
Set::Object already has an C<equals()> method, but it only returns true if
objects within two sets are exactly equal (i.e. have the same references,
referring to the same object instance).  When using Data::Compare in
conjuction with this plugin, objects in sets are considered the same if their
B<contents> are the same.  This extends down to sets that contain arrays,
hashes, or other objects supported by Data::Compare plugins.

=head1 INTERFACE

As a plugin to Data::Compare, the interface is the same as Data::Compare
itself: pass the reference to two data structures to the Compare function,
which for historical reasons is exported by default.

Set::Object also can export certain functions, and overloads comparison
operators pertaining to sets.  Consult the
L<Set::Object documentation|Set::Object> for more information.

=head1 DIAGNOSTICS

See the L<documentation for Data::Compare|Data::Compare>.

=head1 CONFIGURATION AND ENVIRONMENT

Data::Compare::Plugins::Set::Object requires no configuration files or environment variables.

=head1 DEPENDENCIES

=over

=item L<Data::Compare> >= 0.06 (must be installed separately)

=item L<List::MoreUtils> >= 0.04 (must be installed separately)

=item L<version> >= 0.77 (part of the standard Perl 5.10.1 distribution)

=item L<English> (part of the standard Perl 5 distribution)

=back

=head1 INCOMPATIBILITIES

None reported.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-data-compare-plugins-set-object@rt.cpan.org>, or through the web
interface at L<http://rt.cpan.org>.

=head1 AUTHOR

Mark Gardner  C<< <mjgardner@cpan.org> >>

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2009, Mark Gardner C<< <mjgardner@cpan.org> >>. All rights
reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl 5.10.1 itself.

=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.
