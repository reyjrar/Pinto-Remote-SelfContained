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
