use strict;
use warnings;
use Test::More;

use Net::HTTP::API::Spec;

ok my $client = Net::HTTP::API::Spec->load_from_spec('t/spec/test1.json');

my @methods = $client->meta->get_all_net_api_methods();
is scalar @methods, 2;

done_testing;
