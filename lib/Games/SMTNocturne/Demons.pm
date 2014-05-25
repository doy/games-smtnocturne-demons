package Games::SMTNocturne::Demons;
use strict;
use warnings;

use Games::SMTNocturne::Demons::Demon;
use Games::SMTNocturne::Demons::FusionChart;

sub fuse {
    my ($demon1, $demon2) = @_;

    $demon1 = Games::SMTNocturne::Demons::Demon->from_name($demon1)
        unless ref($demon1);
    $demon2 = Games::SMTNocturne::Demons::Demon->from_name($demon2)
        unless ref($demon2);

    my $new_type = Games::SMTNocturne::Demons::FusionChart::fuse(
        $demon1->type, $demon2->type
    );
    my $new_level = ($demon1->level + $demon2->level) / 2;

    return Games::SMTNocturne::Demons::Demon->from_type_and_level(
        $new_type, $new_level
    );
}

sub fusions_for {
    my ($demon) = @_;

    $demon = Games::SMTNocturne::Demons::Demon->from_name($demon)
        unless ref($demon);

    my @fusions;
    my %seen;
    for my $types (Games::SMTNocturne::Demons::FusionChart::unfuse($demon->type)) {
        my ($type1, $type2) = @$types;
        for my $demon1 (Games::SMTNocturne::Demons::Demon->from_type($type1)) {
            for my $demon2 (Games::SMTNocturne::Demons::Demon->from_type($type2)) {
                push @fusions, [ $demon1, $demon2 ]
                    if fuse($demon1, $demon2) eq $demon;
            }
        }
    }

    return @fusions;
}

1;
