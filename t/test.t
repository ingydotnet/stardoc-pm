use Test::More tests => 1;
# use Test::Differences; *is = \&eq_or_diff; warn "X"x80; unified_diff;

use Stardoc::Convert;
use IO::All;

my $pm = 't/Stardoc.pm';

my $pod = Stardoc::Convert->perl_file_to_pod($pm);

is $pod, io('t/Stardoc.pod')->all, 'Stardoc pm to pod works';
