##
# name:      Module::Install::Stardoc
# abstract:  Stardoc Support for Module::Install
# author:    Ingy döt Net <ingy@cpan.org>
# copyright: 2011
# license:   perl

package Module::Install::Stardoc;
use strict;
use warnings;
use 5.008003;

use Module::Install::Base;
use File::Find;

use vars qw($VERSION @ISA);
BEGIN {
    $VERSION = '0.10';
    @ISA     = 'Module::Install::Base';
}

sub stardoc_make_pod {
    my $self = shift;
    return unless $self->is_admin;
    require Stardoc::Convert;
    eval "use IO::All; 1" or die $@;

    my @pms;
    File::Find::find(sub {
        push @pms, $File::Find::name if /\.pm$/;
    }, 'lib');
    for my $pm (@pms) {
        (my $pod = $pm) =~ s/\.pm$/.pod/ or die;
        my $doc = Stardoc::Convert->perl_file_to_pod($pm) or next;
        my $old = -e $pod ? io->($pod)->all : '';
        if ($doc ne $old) {
            print "Creating $pod from $pm\n";
            io($pod)->print($doc);
        }
    }
}

1;

=head1 SYNOPSIS

In Makefile.PL:

    use inc::Module::Install;

    stardoc_make_pod;
    all_from 'lib/Foo.pm';

=head1 DESCRIPTION

This command generates a pod file from every .pm file in your lib/ directory that contains Stardoc documentation.

=cut
