package Games::SMTNocturne::Demons;
use strict;
use warnings;

use Games::SMTNocturne::Demons::Demon;
use Games::SMTNocturne::Demons::FusionChart;

sub fuse {
    my ($demon1, $demon2) = @_;

    $demon1 = Games::SMTNocturne::Demons::Demon->new_from_name($demon1)
        unless ref($demon1);
    $demon2 = Games::SMTNocturne::Demons::Demon->new_from_name($demon2)
        unless ref($demon2);

    my $new_type = Games::SMTNocturne::Demons::FusionChart::fuse(
        $demon1->type, $demon2->type
    );
    my $new_level = ($demon1->level + $demon2->level) / 2;

    return Games::SMTNocturne::Demons::Demon->new_from_type_and_level(
        $new_type, $new_level
    );
}

1;
