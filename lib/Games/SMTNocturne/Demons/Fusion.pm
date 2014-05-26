package Games::SMTNocturne::Demons::Fusion;
use strict;
use warnings;
use overload '""' => 'to_string';

use Games::SMTNocturne::Demons::Demon;

sub new {
    my ($class, $options, $demon1, $demon2, $sacrifice, $kagatsuchi) = @_;

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

    $attrs->{kagatsuchi} = $kagatsuchi;
    $attrs->{options} = $options || {};

    return bless $attrs, $class;
}

sub options    { $_[0]->{options} }
sub demons     { $_[0]->{demons} }
sub sacrifice  { $_[0]->{sacrifice} }
sub deathstone { $_[0]->{deathstone} }
sub kagatsuchi { $_[0]->{kagatsuchi} }
sub result {
    my $self = shift;
    require Games::SMTNocturne::Demons;
    $self->{result} ||= Games::SMTNocturne::Demons::fuse(
        @{ $self->demons },
        {
            %{ $self->options },
            sacrifice  => $self->sacrifice,
            deathstone => $self->deathstone,
            kagatsuchi => @{ $self->kagatsuchi || [] }[0],
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
    push @$array, $self->kagatsuchi
        if defined $self->kagatsuchi;
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
          . join(", ", map { "$_/8" } @{ $self->kagatsuchi })
        if defined $self->kagatsuchi;
    $str .= " resulting in " . $self->result;

    return $str;
}

1;
