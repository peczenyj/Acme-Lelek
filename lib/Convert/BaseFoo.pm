use strict;
use warnings;

package Convert::BaseFoo;
{
    $Convert::BaseFoo = '1.000';
}

# ABSTRACT: encode/decode text to foo code.
use autobox::Core;
use Convert::BaseN;
use List::MoreUtils qw(any);
use Moo;

has prefix => ( is => 'ro', default => sub { q() } );
has base   => ( is => 'lazy' );
has digits => ( is => 'lazy' );
has words  => (
    is  => 'ro',
    isa => sub {
        my $value = scalar( @{ $_[0] } );
        any { $value == $_ } ( 2, 4, 8, 16, 32, 64 );
    },
    required => 1
);

sub total_words {
    scalar @{ $_[0]->words };
}

sub _build_digits {
    my $self = shift;

    +{ map { $self->words->[$_] => $_ } 0 .. $self->total_words - 1 };
}

sub _build_base {
    Convert::BaseN->new( base => $_[0]->total_words );
}

sub encode {
    my ( $self, $msg ) = @_;

    $self->base->encode($msg)->split('')->grep(qr/^[^=]+$/)
      ->map( sub { $self->words->[$_] } )->unshift( $self->prefix )
      ->grep(qr/\S+/)->join(' ');
}

sub decode {
    my ( $self, $msg ) = @_;
    $msg->s( qr/@{[$self->prefix]}/, q() );
    $self->base->decode(
        $msg->split(qr/\s+/)->grep(qr/\S+/)->map(
            sub {
                $self->digits->{$_};
            }
          )->join('')
    );
}

1;

__END__

=head1 NAME

Convert::BaseFoo - encode/decode text to foo code.

=head1 SYNOPSYS

  use feature 'say';

  my $foo = Convert::BaseFoo->new( words => [ qw(foo foO fOo Foo fOO FoO FOo FOO) ]);
  my $encoded = $foo->encode("bar");

  say "encoded : $encoded";
  say "original: " . $foo->decode($encoded);
  
=head1 Methods

=head2 encode

Will encode the string in foo code.
  
  $lek->encode("bar");
  # returns : "Foo foo fOO FOo foo FoO FOo fOo"

=head2 decode

Will decode the foo code

  $lek->decode("Foo foo fOO FOo foo FoO FOo fOo");
  # will return "bar"
