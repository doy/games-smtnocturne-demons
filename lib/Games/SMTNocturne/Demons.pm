package Games::SMTNocturne::Demons;
use strict;
use warnings;

use Exporter 'import';
our @EXPORT_OK = qw(demon demons_of_type all_demons fuse fusions_for);

use Games::SMTNocturne::Demons::Demon;
use Games::SMTNocturne::Demons::Fusion;
use Games::SMTNocturne::Demons::FusionChart;

sub demon {
    my ($demon) = @_;

    return Games::SMTNocturne::Demons::Demon->from_name($demon);
}

sub demons_of_type {
    my ($type) = @_;

    return Games::SMTNocturne::Demons::Demon->from_type($type);
}

sub all_demons {
    return Games::SMTNocturne::Demons::Demon->all_demons;
}

sub fuse {
    my ($demon1, $demon2, $options) = @_;
    $options = { %{ $options || {} } };

    $demon1 = demon($demon1) unless ref($demon1);
    $demon2 = demon($demon2) unless ref($demon2);
    if ($options->{sacrifice}) {
        $options->{sacrifice} = demon($options->{sacrifice})
            unless ref($options->{sacrifice});
    }

    if (!$options->{basic}) {
        if (my $demon = _try_special_fusion($demon1, $demon2, $options)) {
            # XXX this is the wrong place for this, but not sure how to do
            # it better
            return if $demon->type eq 'Fiend'
                   && ($demon1->type eq 'Fiend' || $demon2->type eq 'Fiend');
            return $demon;
        }
        else {
            $options->{fusion_type} = 'normal';
        }
    }

    if ($demon1->type eq 'Element' && $demon2->type eq 'Element') {
        return _fuse_mitama($demon1, $demon2, $options);
    }
    elsif ($demon1->type eq 'Element' || $demon2->type eq 'Element') {
        return _element_fusion(
            ($demon1->type eq 'Element'
                ? ($demon1, $demon2) : ($demon2, $demon1)),
            $options
        );
    }
    elsif ($demon1->type eq 'Mitama' && $demon2->type eq 'Mitama') {
        return;
    }
    elsif ($demon1->type eq 'Mitama' || $demon2->type eq 'Mitama') {
        return _mitama_fusion(
            ($demon1->type eq 'Mitama'
                ? ($demon1, $demon2) : ($demon2, $demon1)),
            $options
        );
    }
    elsif ($demon1->type eq $demon2->type) {
        return _fuse_element($demon1, $demon2, $options);
    }
    else {
        return _normal_fusion($demon1, $demon2, $options);
    }
}

sub fusions_for {
    my ($demon, $options) = @_;

    $demon = demon($demon) unless ref($demon);

    my @fusions;
    my %seen;
    for my $types (Games::SMTNocturne::Demons::FusionChart::unfuse($demon->type)) {
        my ($type1, $type2) = @$types;
        for my $demon1 (Games::SMTNocturne::Demons::Demon->from_type($type1)) {
            next if defined $options->{max_level}
                 && $options->{max_level} < $demon1->level;
            for my $demon2 (Games::SMTNocturne::Demons::Demon->from_type($type2)) {
                next if defined $options->{max_level}
                     && $options->{max_level} < $demon2->level;
                push @fusions, [ $options, $demon1, $demon2 ]
                    if (fuse($demon1, $demon2, $options) || '') eq $demon;
            }
        }
    }

    my $special = Games::SMTNocturne::Demons::FusionChart::special_fusion_for(
        $demon->name
    );
    my @special_fusions;
    if ($special) {
        for my $key (qw(demon1 demon2 demon3 target sacrifice)) {
            next unless $special->{$key};
            if (my $name = $special->{$key}{name}) {
                $special->{$key} = [ demon($name) ];
            }
            elsif (my $type = $special->{$key}{type}) {
                my @types = ref($type) ? (@$type) : ($type);
                $special->{$key} = [
                    map {
                        Games::SMTNocturne::Demons::Demon->from_type($_)
                    } @types
                ];
            }
            $special->{$key} = [
                grep { $_->level <= $options->{max_level} }
                     @{ $special->{$key} }
            ] if $key ne 'target' && defined $options->{max_level};
        }

        if ($special->{demon3}) {
            for my $demon1 (@{ $special->{demon1} }) {
                for my $demon2 (@{ $special->{demon2} }) {
                    for my $demon3 (@{ $special->{demon3} }) {
                        push @special_fusions, [
                            $options, $demon1, $demon2, $demon3
                        ];
                        push @special_fusions, [
                            $options, $demon1, $demon3, $demon2
                        ];
                        push @special_fusions, [
                            $options, $demon2, $demon3, $demon1
                        ];
                    }
                }
            }
        }
        elsif ($special->{demon2}) {
            for my $demon1 (@{ $special->{demon1} }) {
                for my $demon2 (@{ $special->{demon2} }) {
                    push @special_fusions, [ $options, $demon1, $demon2 ];
                }
            }
        }
        elsif ($special->{demon1}) {
            if ($special->{target}) {
                my @target_fusions = map {
                    $_->raw
                } map {
                    fusions_for($_, $options)
                } @{ $special->{target} };
                push @special_fusions, grep {
                    my $fusion = $_;
                    grep { $_ eq $fusion->[0] || $_ eq $fusion->[1] }
                         @{ $special->{demon1} }
                } @target_fusions;
            }
            else {
                die "???";
            }
        }
        else {
            if ($special->{target}) {
                my @new_special = map {
                    $_->raw
                } map {
                    fusions_for($_, $options)
                } @{ $special->{target} };
                if ($demon->type eq 'Fiend') {
                    @new_special = grep {
                        $_->[1]->type ne 'Fiend' && $_->[2]->type ne 'Fiend'
                    } @new_special;
                }
                push @special_fusions, @new_special;
            }
            else {
                die "???";
            }
        }

        if ($special->{sacrifice}) {
            @special_fusions = map {
                my $sac = $_;
                map { [ @$_, $sac ] } @special_fusions
            } @{ $special->{sacrifice} };
        }

        if ($special->{deathstone}) {
            push @$_, '<deathstone>' for @special_fusions;
        }

        if ($special->{kagutsuchi}) {
            push @$_, $special->{kagutsuchi} for @special_fusions;
        }
    }

    return map { Games::SMTNocturne::Demons::Fusion->new(@$_) }
               @fusions, @special_fusions;
}

sub _try_special_fusion {
    my ($demon1, $demon2, $options) = @_;

    my $fused = Games::SMTNocturne::Demons::FusionChart::special_fusion(
        $demon1, $demon2, $options
    );
    return unless $fused;

    my $demon = demon($fused);

    my %bosses = map { $_ => 1 } @{ $options->{bosses} || [] };
    return if $demon->boss && !$bosses{$demon->name};

    return $demon;
}

sub _fuse_mitama {
    my ($element1, $element2) = @_;

    my $mitama = Games::SMTNocturne::Demons::FusionChart::fuse_mitama(
        $element1->name, $element2->name
    );
    return unless $mitama;
    return demon($mitama);
}

sub _element_fusion {
    my ($element, $demon, $options) = @_;

    my $direction = Games::SMTNocturne::Demons::FusionChart::element_fusion(
        $demon->type, $element->name
    );
    return unless $direction;

    return Games::SMTNocturne::Demons::Demon->from_fusion_stats({
        type   => $demon->type,
        level  => $demon->level,
        offset => $direction,
        %{ $options || {} },
    });
}

sub _mitama_fusion {
    my ($mitama, $demon) = @_;

    return $demon;
}

sub _fuse_element {
    my ($demon1, $demon2) = @_;

    my $element = Games::SMTNocturne::Demons::FusionChart::fuse_element(
        $demon1->type
    );
    return unless $element;
    return demon($element);
}

sub _normal_fusion {
    my ($demon1, $demon2, $options) = @_;

    my $new_type = Games::SMTNocturne::Demons::FusionChart::fuse(
        $demon1->type, $demon2->type
    );
    return unless $new_type;

    my $new_level = ($demon1->level + $demon2->level) / 2 + 1;

    return Games::SMTNocturne::Demons::Demon->from_fusion_stats({
        type  => $new_type,
        level => $new_level,
        %{ $options || {} },
    });
}

1;
