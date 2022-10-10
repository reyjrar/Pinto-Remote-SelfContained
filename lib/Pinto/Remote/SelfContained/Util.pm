package
    Pinto::Remote::SelfContained::Util; # hide from PAUSE
# ABSTRACT: various utility functions

use v5.10;
use strict;
use warnings;

use Capture::Tiny qw(capture);
use Carp qw(croak);
use Time::Moment;
use IO::Interactive qw(is_interactive);
use Term::ReadKey;

use Exporter qw(import);

# VERSION

our @EXPORT_OK = qw(
    current_time_offset
    current_username
    get_password
    mask_uri_passwords
    password_exec
);

sub current_time_offset { Time::Moment->now->offset }

sub current_username {
    return $ENV{PINTO_USERNAME} // $ENV{USER} // $ENV{LOGIN} // $ENV{USERNAME} // $ENV{LOGNAME}
        // croak("Can't determine username; try setting \$PINTO_USERNAME");
}

sub get_password {
    # Environment Set
    return $ENV{PINTO_PASSWORD} if $ENV{PINTO_PASSWORD};

    # Try password exec
    return password_exec($ENV{PINTO_PASSEXEC})
        if $ENV{PINTO_PASSEXEC};

    if( is_interactive() ) {
        local $|=1;
        printf "Pinto password: ";
        ReadMode('noecho');
        my $password = ReadLine();
        ReadMode('normal');
        chomp($password);
        return $password;
    }

    return;
}

sub mask_uri_passwords {
    my ($uri) = @_;

    $uri =~ s{ (https?://[^:/@]+ :) [^@/]+@}{$1*password*@}gx;
    return $uri;
}

sub password_exec {
    my (@cmd) = @_;

    my ($out,$err,$rc) = capture { system @cmd };

    if( $rc == 0 ) {
        chomp($out);
        warn sprintf "password_exec(%s) returned empty password", join(' ', @cmd)
            unless length $out;
        return $out;
    }

    # Unsuccesful
    die sprintf "password_exec(%s) returned non-zero exit code: rc=%d, stderr='%s'",
        $rc, $err;
}

1;
