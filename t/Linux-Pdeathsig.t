# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Linux-Pdeathsig.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 1;
BEGIN { use_ok('Linux::Pdeathsig') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

ok(&Linux::Pdeathsig::SYS_prctl,'got SYS_prctl constant');
ok(&Linux::Pdeathsig::PR_SET_PDEATHSIG,'got PR_SET_PDEATHSIG constant');
ok(&Linux::Pdeathsig::PR_GET_PDEATHSIG,'got PR_GET_PDEATHSIG constant');

