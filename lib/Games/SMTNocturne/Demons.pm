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

    if ($demon1->type eq 'Element' && $demon2->type eq 'Element') {
        return _fuse_mitama($demon1, $demon2);
    }
    elsif ($demon1->type eq 'Element' || $demon2->type eq 'Element') {
        return _element_fusion(
            $demon1->type eq 'Element'
                ? ($demon1, $demon2) : ($demon2, $demon1)
        );
    }
    elsif ($demon1->type eq 'Mitama' && $demon2->type eq 'Mitama') {
        # XXX what does this do?
    }
    elsif ($demon1->type eq 'Mitama' || $demon2->type eq 'Mitama') {
        return _mitama_fusion(
            $demon1->type eq 'Mitama'
                ? ($demon1, $demon2) : ($demon2, $demon1)
        );
    }
    elsif ($demon1->type eq $demon2->type) {
        return _fuse_element($demon1, $demon2);
    }
    else {
        return _normal_fusion($demon1, $demon2);
    }
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

sub _fuse_mitama {
    my ($element1, $element2) = @_;

    die "element fusion nyi";
}

sub _element_fusion {
    my ($element, $demon) = @_;

    die "element fusion nyi";
}

sub _mitama_fusion {
    my ($mitama, $demon) = @_;

    return $demon;
}

sub _fuse_element {
    my ($demon1, $demon2) = @_;

    die "element fusion nyi";
}

sub _normal_fusion {
    my ($demon1, $demon2) = @_;

    my $new_type = Games::SMTNocturne::Demons::FusionChart::fuse(
        $demon1->type, $demon2->type
    );
    return unless $new_type;

    my $new_level = ($demon1->level + $demon2->level) / 2 + 1;

    return Games::SMTNocturne::Demons::Demon->from_fusion_stats(
        $new_type, $new_level, 'normal'
    );
}

1;
