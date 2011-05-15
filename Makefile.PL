use lib 'lib';

use inc::Module::Install;

stardoc_make_pod;
all_from 'lib/Stardoc.pm';
readme_from 'lib/Stardoc.pod';

requires 'Mouse';
requires 'YAML::XS';

WriteAll;

# finalize;
