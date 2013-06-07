use strict;
use warnings;
package Acme::Lelek;

# ABSTRACT: encode/decode text to lelek code.

use Convert::BaseN;
use Const::Fast;
use Moo;

const my @leks   => qw(lek leK lEk Lek lEK LeK LEk LEK);
const my %octals => map { $leks[$_] => $_ } 0..7;

has base8  => (is => 'ro', default => sub { 
  Convert::BaseN->new(base => 8) 
});

sub encode {
  my ($self, $msg) = @_;
  "AH " . join q( ), map { $leks[$_] } grep /^[0-8]$/, split q(), $self->base8->encode($msg);
}

sub decode {
  my ($self, $msg) = @_;
  $self->base8->decode(join q(), map { $octals{$_} } grep /^lek$/i, split(qr/\s+/, $msg));
}

1;

__END__

=head1 NAME

Acme::Lelek - encode/decode text to lelek code.

=head1 SYNOPSYS

  use feature 'say';

  my $lek = Acme::Lelek->new;
  my $encoded = $lek->encode("LOL");

  say "encoded : $encoded";
  say "original: " . $lek->decode($encoded);
  
=head1 Methods

=head2 encode

Will encode the string in lelek code.
  
  $lek->encode("LOL");
  # returns : "AH lEk Lek lek lEK LEK LeK leK lEK"

=head2 decode

Will decode the lelek code

  $lek->decode("AH lEk Lek lek lEK LEK LeK leK lEK");
  # will return "LOL"
  
=head1 SEE ALSO

AH LELEK LEK LEK LEK LEK ( OFICIAL ) HD
L<http://www.youtube.com/watch?v=E1AC_k9izjY>

=cut