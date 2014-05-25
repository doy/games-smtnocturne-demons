package Test::Games::SMTNocturne::Demons;
use strict;
use warnings;
use Exporter 'import';

use Games::SMTNocturne::Demons;
use Test::More;

our @EXPORT = ('fusion_is');

sub fusion_is {
    local $Test::Builder::Level = $Test::Builder::Level + 1;
    my ($demon1, $demon2, $expected) = @_;

    my $fused = eval { Games::SMTNocturne::Demons::fuse($demon1, $demon2) };

    die $@ if $@ && $@ !~ /\bnyi\b/;
    local $TODO = $@ if $@;

    if ($fused) {
        is($fused->name, $expected);
    }
    else {
        is(undef, $expected);
    }
}

1;
