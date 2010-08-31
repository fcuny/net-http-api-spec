use strict;
use warnings;
use Test::More;
use Test::Exception;

use Net::HTTP::API::Spec;

ok my $client = Net::HTTP::API::Spec->new_from_spec('t/spec/test1.json');

dies_ok {
    $client = Net::HTTP::API::Spec->new_from_spec('foobarbaz');
};

like $@, qr/does not exists/;

my @methods = $client->meta->get_all_net_api_methods();
is scalar @methods, 2;

done_testing;
