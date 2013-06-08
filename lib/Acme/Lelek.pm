use strict;
use warnings;

package Acme::Lelek;
{
    $Acme::Lelek::VERSION = '1.004';
}

# ABSTRACT: encode/decode text to lelek code.
use Convert::BaseFoo;
use Moo;

has _lek => (
    is      => 'ro',
    default => sub {
        Convert::BaseFoo->new(
            prefix => q(AH Le),
            words  => [qw(lek leK lEk Lek lEK LeK LEk LEK)]
        );
    },
    handles => [qw(encode decode)]
);

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
  # returns : "AH Le lEk Lek lek lEK LEK LeK leK lEK"

=head2 decode

Will decode the lelek code

  $lek->decode("AH Le lEk Lek lek lEK LEK LeK leK lEK");
  # will return "LOL"
  
=head1 SEE ALSO

AH LELEK LEK LEK LEK LEK ( OFICIAL ) HD
L<http://www.youtube.com/watch?v=E1AC_k9izjY>

=cut
