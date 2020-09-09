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
