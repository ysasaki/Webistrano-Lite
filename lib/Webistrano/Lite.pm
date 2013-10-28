package Webistrano::Lite;
use strict;
use warnings;
use utf8;
our $VERSION='0.01';
use 5.008001;
use Teng::Schema::Loader;

use parent qw/Amon2/;
# Enable project local mode.
__PACKAGE__->make_local_context();

sub db {
    my $c = shift;
    if (!exists $c->{db}) {
        my $conf = $c->config->{DBI}
            or die "Missing configuration about DBI";
        $c->{db} = Teng::Schema::Loader->load(
            namespace    => 'Webistrano::Lite::DB',
            connect_info => [@$conf],
        );
    }
    $c->{db};
}

1;
__END__

=head1 NAME

Webistrano::Lite - Yet Another Web Interface for Capistrano

=head1 DESCRIPTION

This is a main context class for Webistrano::Lite

=head1 AUTHOR

Yoshihiro Sasaki E<lt>ysasaki@cpan.rogE<gt>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

