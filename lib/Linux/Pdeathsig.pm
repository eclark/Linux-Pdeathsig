package Linux::Pdeathsig;

use 5.008007;
use strict;
use warnings;
use Carp;

require Exporter;
use AutoLoader;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Linux::Pdeathsig ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	set_pdeathsig
    get_pdeathsig
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	set_pdeathsig
    get_pdeathsig
);

our $VERSION = '0.00_01';
our $XS_VERSION = $VERSION;
$VERSION = eval $VERSION;  # see L<perlmodstyle>

sub AUTOLOAD {
    # This AUTOLOAD is used to 'autoload' constants from the constant()
    # XS function.

    my $constname;
    our $AUTOLOAD;
    ($constname = $AUTOLOAD) =~ s/.*:://;
    croak "&Linux::Pdeathsig::constant not defined" if $constname eq 'constant';
    my ($error, $val) = constant($constname);
    if ($error) { croak $error; }
    {
	no strict 'refs';
	# Fixed between 5.005_53 and 5.005_61
#XXX	if ($] >= 5.00561) {
#XXX	    *$AUTOLOAD = sub () { $val };
#XXX	}
#XXX	else {
	    *$AUTOLOAD = sub { $val };
#XXX	}
    }
    goto &$AUTOLOAD;
}

require XSLoader;
XSLoader::load('Linux::Pdeathsig', $XS_VERSION);

# Preloaded methods go here.

sub set_pdeathsig {
    my $signal = shift;
    croak 'no signal defined for set_pdeathsig' if !defined $signal;

    my $ret = syscall(&SYS_prctl,&PR_SET_PDEATHSIG,$signal); 
    if ($ret == -1 || $ret == &EINVAL) {
        croak 'set_pdeathsig: ' . $!;
    }
    return $ret;
}

sub get_pdeathsig {
    my $value = "    ";
    my $ret = syscall(&SYS_prctl,&PR_GET_PDEATHSIG,$value);
    if ($ret == -1 || $ret == &EINVAL) {
        croak 'get_pdeathsig: ' . $!;
    }
    return unpack('i',$value);
}

# Autoload methods go after =cut, and are processed by the autosplit program.

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Linux::Pdeathsig - Perl extension for blah blah blah

=head1 SYNOPSIS

  use Linux::Pdeathsig;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for Linux::Pdeathsig, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

Eric Clark, E<lt>eclark@gsc.wustl.eduE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by Eric Clark

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.7 or,
at your option, any later version of Perl 5 you may have available.


=cut
