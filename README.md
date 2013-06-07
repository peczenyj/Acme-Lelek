Acme::Lelek
===========

encode/decode text to lelek code.

```perl
    use feature 'say';

    my $lek = Acme::Lelek->new;
    my $encoded = $lek->encode("LOL");

    say "encoded : $encoded";
    say "original: " . $lek->decode($encoded);
```

SEE ALSO
========

[AH LELEK LEK LEK LEK LEK ( OFICIAL ) HD](http://www.youtube.com/watch?v=E1AC_k9izjY)