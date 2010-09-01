package Net::HTTP::API::Spec;

use Moose;

use IO::All;
use JSON;
use Carp;
use Try::Tiny;

use Net::HTTP::API::Core;

sub new_from_spec {
    my ($class, $spec_file) = @_;

    # TODO:
    # - load from an url
    if (! -f $spec_file) {
        Carp::confess ("$spec_file does not exists");
    }

    my ($content, $spec);

    $content < io($spec_file);

    try {
        $spec = JSON::decode_json($content);
    }
    catch {
        Carp::Confess( "unable to parse JSON spec: " . $_ );
    };

    my $net_api_class =
      Class::MOP::Class->create_anon_class(
          superclasses => ['Net::HTTP::API::Core']);

    my $net_api_object;
    try {
        $net_api_object = $net_api_class->new_object;

        $net_api_object = _declare_api($net_api_object, $spec->{declare});
        $net_api_object = _add_methods($net_api_object, $spec->{methods});

    }catch{
        Carp::Confess("unable to create new Net::HTTP::API object: ".$_);
    };

    return $net_api_object;
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
