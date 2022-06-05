package
    Pinto::Remote::SelfContained::Action::Add; # hide from PAUSE
# ABSTRACT: add a distribution to a the repository

use v5.10;
use Moo;

use Carp qw(croak);
use Pinto::Remote::SelfContained::Types qw(SingleBodyPart);

use namespace::clean;

# VERSION

extends qw(Pinto::Remote::SelfContained::Action);

has archives => (is => 'ro', isa => SingleBodyPart, required => 1);

around BUILDARGS => sub {
    my ($orig, $class, @rest) = @_;

    my $args = $class->$orig(@rest);

    $args->{args}{author} //= $ENV{PINTO_AUTHOR_ID}
        if defined $ENV{PINTO_AUTHOR_ID};

    $args->{archives} //= delete $args->{args}{archives};

    return $args;
};

around _make_body_parts => sub {
    my ($orig, $self) = @_;

    my $body = $self->$orig;
    my $archives = $self->archives;
    push @$body, @$archives;

    return $body;
};

1;
