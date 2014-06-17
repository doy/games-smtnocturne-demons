package Games::SMTNocturne::Demons::Fusion;
use strict;
use warnings;
use overload '""' => 'to_string';
# ABSTRACT: represents the results of a fusion

use Games::SMTNocturne::Demons::Demon;

=head1 SYNOPSIS

  use Games::SMTNocturne::Demons 'fusions_for';

  my @fusions = fusions_for('Jack Frost');

  say $fusions[0]->demons->[0]; # <Divine Angel (11)>
  say $fusions[0]->demons->[1]; # <Foul Will o' Wisp (1)>
  say $fusions[0]->result;      # <Fairy Jack Frost (7)>
  say $fusions[0];              # Fuse <Divine Angel (11)> with <Foul Will o' Wisp (1)> resulting in <Fairy Jack Frost (7)>

=head1 DESCRIPTION

This class represents the result of a demon fusion which was calculated by the
C<fusions_for> function in L<Games::SMTNocturne::Demons>. It includes various
accessor methods to get information about the generated fusion, as well as a
stringification overload to produce a readable summary.

=cut

sub new {
    my ($class, $options, $demon1, $demon2, $sacrifice, $kagutsuchi) = @_;

    my $attrs = {};

    $demon1 = Games::SMTNocturne::Demons::Demon->from_name($demon1)
        unless ref($demon1);
    $demon2 = Games::SMTNocturne::Demons::Demon->from_name($demon2)
        unless ref($demon2);
    $attrs->{demons} = [ sort { $a->name cmp $b->name } $demon1, $demon2 ];

    if ($sacrifice) {
        if ($sacrifice eq '<deathstone>') {
            $attrs->{deathstone} = 1;
        }
        else {
            $sacrifice = Games::SMTNocturne::Demons::Demon->from_name($sacrifice)
                unless ref($sacrifice);
            $attrs->{sacrifice} = $sacrifice;
        }
    }

    $attrs->{kagutsuchi} = $kagutsuchi;
    $attrs->{options} = $options || {};

    return bless $attrs, $class;
}

=method demons

An arrayref containing the two demons to be fused.

=method sacrifice

An optional third demon to be sacrificed (at full Kagutsuchi).

=method deathstone

True if this fusion requires a deathstone.

=method kagutsuchi

An optional arrayref containing the Kagutsuchi phases during which this fusion
may take place.

=method result

The demon that will be created by the fusion.

=cut

sub options    { $_[0]->{options} }
sub demons     { $_[0]->{demons} }
sub sacrifice  { $_[0]->{sacrifice} }
sub deathstone { $_[0]->{deathstone} }
sub kagutsuchi { $_[0]->{kagutsuchi} }
sub result {
    my $self = shift;
    require Games::SMTNocturne::Demons;
    $self->{result} ||= Games::SMTNocturne::Demons::fuse(
        @{ $self->demons },
        {
            %{ $self->options },
            sacrifice  => $self->sacrifice,
            deathstone => $self->deathstone,
            kagutsuchi => @{ $self->kagutsuchi || [] }[0],
        }
    );
}

sub all_demons {
    my $self = shift;

    return (
        @{ $self->demons },
        ($self->sacrifice ? ($self->sacrifice) : ()),
    );
}

sub raw {
    my $self = shift;
    my $array = [ $self->options, @{ $self->demons } ];
    push @$array, $self->sacrifice
        if $self->sacrifice;
    push @$array, "<deathstone>"
        if $self->deathstone;
    push @$array, $self->kagutsuchi
        if defined $self->kagutsuchi;
    return $array;
}

sub to_string {
    my $self = shift;

    my $str = "Fuse " . $self->demons->[0]
            . " with " . $self->demons->[1];

    $str .= " while sacrificing " . $self->sacrifice
        if $self->sacrifice;
    $str .= " while sacrificing a deathstone"
        if $self->deathstone;
    $str .= " when Kagutsuchi is at phase "
          . join(", ", map { "$_/8" } @{ $self->kagutsuchi })
        if defined $self->kagutsuchi;
    $str .= " resulting in " . $self->result;

    return $str;
}

1;
