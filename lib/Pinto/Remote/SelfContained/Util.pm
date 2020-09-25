package
    Pinto::Remote::SelfContained::Util; # hide from PAUSE

use v5.10;
use strict;
use warnings;

use Time::Moment;

use Exporter qw(import);

our @EXPORT_OK = qw(
    current_time_offset
    mask_uri_passwords
);

sub current_time_offset { Time::Moment->now->offset }

sub mask_uri_passwords {
    my ($uri) = @_;

    $uri =~ s{ (https?://[^:/@]+ :) [^@/]+@}{$1*password*@}gx;
    return $uri;
}

1;
__END__

=head1 NAME

Pinto::Remote::SelfContained::Util - various utility functions

=head1 AUTHOR

Aaron Crane, E<lt>arc@cpan.orgE<gt>

=head1 COPYRIGHT

Copyright 2020 Aaron Crane.

=head1 LICENSE

This library is free software and may be distributed under the same terms
as perl itself. See L<http://dev.perl.org/licenses/>.

=cut
