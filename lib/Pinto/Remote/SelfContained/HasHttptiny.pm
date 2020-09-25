package
    Pinto::Remote::SelfContained::HasHttptiny; # hide from PAUSE

use v5.10;
use Moo::Role;

use HTTP::Tiny;
use Types::Standard qw(InstanceOf);

use namespace::clean;

has httptiny => (
    is => 'lazy',
    isa => InstanceOf['HTTP::Tiny'],
    default => sub { HTTP::Tiny->new(verify_SSL => 1) },
);

1;
__END__

=head1 NAME

Pinto::Remote::SelfContained::HasHttptiny - role providing an HTTP::Tiny instance

=head1 AUTHOR

Aaron Crane, E<lt>arc@cpan.orgE<gt>

=head1 COPYRIGHT

Copyright 2020 Aaron Crane.

=head1 LICENSE

This library is free software and may be distributed under the same terms
as perl itself. See L<http://dev.perl.org/licenses/>.

=cut