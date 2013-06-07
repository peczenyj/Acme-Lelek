use Test::More tests => 2;
use Acme::Lelek;

my $lek = Acme::Lelek->new;

is($lek->encode("LOL"), "lEk Lek lek lEK LEK LeK leK lEK");
is($lek->decode("lEk Lek lek lEK LEK LeK leK lEK"), "LOL");