package
    Pinto::Remote::SelfContained::Result;
# ABSTRACT: the result of running an Action

use v5.10;
use Moo;

use Types::Standard qw(Bool);

use namespace::clean;

# VERSION

use overload q[""] => 'to_string';

has made_changes => (
    is => 'ro',
    isa => Bool,
    writer => '_set_made_changes',
    default => 0,
);

has was_successful => (
    is => 'ro',
    isa => Bool,
    writer => '_set_was_successful',
    default => 1,
);

sub exceptions {}
sub add_exception {}

sub failed {
    my ($self, %args) = @_;

    # ignore "because" arg
    $self->_set_was_successful(0);
    return $self;
}

sub changed {
    my ($self) = @_;

    $self->_set_made_changes(1);
    return $self;
}

sub exit_status {
    my ($self) = @_;

    return $self->was_successful ? 0 : 1;
}

sub to_string {
    my ($self) = @_;

    return $self->was_successful ? 'ok' : 'unknown error';
}

1;
