package Net::HTTP::API::Spec;

use JSON;
use Moose;
use IO::All;

use Net::HTTP::API::Core;

sub load_from_spec {
    my ($class, $spec_file) = @_;

    my $content < io($spec_file);
    my $spec = JSON::decode_json($content);

    my $net_api_class =
      Class::MOP::Class->create_anon_class(
          superclasses => ['Net::HTTP::API::Core']);

    my $net_api_object = $net_api_class->new_object;

    $net_api_object = _declare_api($net_api_object, $spec->{declare});
    $net_api_object = _add_methods($net_api_object, $spec->{methods});

    $net_api_object;
}

sub _declare_api {
    my ($api, $declaration_spec) = @_;

    foreach my $k (keys %$declaration_spec) {
        $api->meta->set_api_option($k => $declaration_spec->{$k});
    }
    $api;
}

sub _add_methods {
    my ($class, $methods_spec) = @_;

    foreach my $method_name (keys %$methods_spec) {
        $class->meta->add_net_api_method($method_name,
            %{$methods_spec->{$method_name}});
    }
    $class;
}

1;
