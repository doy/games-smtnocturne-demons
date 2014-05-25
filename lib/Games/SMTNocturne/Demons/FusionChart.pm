package Games::SMTNocturne::Demons::FusionChart;
use strict;
use warnings;

use JSON::PP;

my %TYPES = %{ decode_json(do { local $/; <DATA> }) };

sub fuse {
    my ($type1, $type2) = @_;

    die "unknown demon type $type1" unless $TYPES{$type1};
    die "unknown demon type $type2" unless $TYPES{$type2};

    return $TYPES{$type1}{$type2};
}

sub unfuse {
    my ($type) = @_;

    die "unknown demon type $type" unless $TYPES{$type};

    my @combinations;
    for my $type1 (keys %TYPES) {
        for my $type2 (grep { $_ le $type1 } keys %TYPES) {
            push @combinations, [ $type1, $type2 ]
                if $TYPES{$type1}{$type2} eq $type;
        }
    }

    return @combinations;
}

1;

__DATA__
{
   "Avatar" : {
      "Avatar" : null,
      "Avian" : "Holy",
      "Beast" : "Snake",
      "Brute" : "Kishin",
      "Deity" : "Megami",
      "Divine" : "Megami",
      "Dragon" : "Fury",
      "Element" : null,
      "Entity" : "Fury",
      "Fairy" : "Divine",
      "Fallen" : "Divine",
      "Femme" : "Kishin",
      "Fiend" : null,
      "Foul" : null,
      "Fury" : "Holy",
      "Genma" : "Kishin",
      "Haunt" : null,
      "Holy" : "Megami",
      "Jirae" : "Kishin",
      "Kishin" : "Holy",
      "Lady" : "Fury",
      "Megami" : "Deity",
      "Mitama" : "Avatar",
      "Night" : "Holy",
      "Raptor" : "Wilder",
      "Seraph" : "Deity",
      "Snake" : "Lady",
      "Tyrant" : null,
      "Vile" : "Deity",
      "Wargod" : "Deity",
      "Wilder" : null,
      "Yoma" : "Divine"
   },
   "Avian" : {
      "Avatar" : "Holy",
      "Avian" : null,
      "Beast" : "Femme",
      "Brute" : "Kishin",
      "Deity" : "Megami",
      "Divine" : "Snake",
      "Dragon" : "Fury",
      "Element" : null,
      "Entity" : "Deity",
      "Fairy" : "Night",
      "Fallen" : "Snake",
      "Femme" : "Brute",
      "Fiend" : null,
      "Foul" : null,
      "Fury" : "Kishin",
      "Genma" : "Megami",
      "Haunt" : null,
      "Holy" : "Lady",
      "Jirae" : "Kishin",
      "Kishin" : "Lady",
      "Lady" : null,
      "Megami" : "Deity",
      "Mitama" : "Avian",
      "Night" : "Femme",
      "Raptor" : "Megami",
      "Seraph" : "Megami",
      "Snake" : "Kishin",
      "Tyrant" : null,
      "Vile" : null,
      "Wargod" : "Kishin",
      "Wilder" : null,
      "Yoma" : "Night"
   },
   "Beast" : {
      "Avatar" : "Snake",
      "Avian" : "Femme",
      "Beast" : "Element",
      "Brute" : "Femme",
      "Deity" : "Avatar",
      "Divine" : "Holy",
      "Dragon" : "Snake",
      "Element" : "Beast",
      "Entity" : "Holy",
      "Fairy" : "Divine",
      "Fallen" : "Night",
      "Femme" : "Foul",
      "Fiend" : "Night",
      "Foul" : "Wilder",
      "Fury" : "Avatar",
      "Genma" : "Fairy",
      "Haunt" : "Wilder",
      "Holy" : "Avatar",
      "Jirae" : "Yoma",
      "Kishin" : "Holy",
      "Lady" : "Snake",
      "Megami" : "Holy",
      "Mitama" : "Beast",
      "Night" : "Fairy",
      "Raptor" : "Wilder",
      "Seraph" : null,
      "Snake" : "Brute",
      "Tyrant" : "Night",
      "Vile" : "Foul",
      "Wargod" : "Holy",
      "Wilder" : "Jirae",
      "Yoma" : "Fallen"
   },
   "Brute" : {
      "Avatar" : "Kishin",
      "Avian" : "Kishin",
      "Beast" : "Femme",
      "Brute" : "Element",
      "Deity" : "Kishin",
      "Divine" : "Yoma",
      "Dragon" : "Night",
      "Element" : "Brute",
      "Entity" : "Fury",
      "Fairy" : "Night",
      "Fallen" : "Jirae",
      "Femme" : "Beast",
      "Fiend" : "Haunt",
      "Foul" : "Wilder",
      "Fury" : "Lady",
      "Genma" : "Divine",
      "Haunt" : "Foul",
      "Holy" : "Femme",
      "Jirae" : "Fairy",
      "Kishin" : "Snake",
      "Lady" : "Fury",
      "Megami" : "Femme",
      "Mitama" : "Brute",
      "Night" : "Kishin",
      "Raptor" : "Fury",
      "Seraph" : null,
      "Snake" : "Beast",
      "Tyrant" : "Haunt",
      "Vile" : "Haunt",
      "Wargod" : null,
      "Wilder" : "Fairy",
      "Yoma" : "Femme"
   },
   "Deity" : {
      "Avatar" : "Megami",
      "Avian" : "Megami",
      "Beast" : "Avatar",
      "Brute" : "Kishin",
      "Deity" : null,
      "Divine" : "Megami",
      "Dragon" : null,
      "Element" : "Deity",
      "Entity" : "Megami",
      "Fairy" : "Night",
      "Fallen" : "Fury",
      "Femme" : "Lady",
      "Fiend" : null,
      "Foul" : null,
      "Fury" : null,
      "Genma" : "Megami",
      "Haunt" : null,
      "Holy" : "Megami",
      "Jirae" : "Brute",
      "Kishin" : "Fury",
      "Lady" : null,
      "Megami" : null,
      "Mitama" : "Deity",
      "Night" : "Vile",
      "Raptor" : "Tyrant",
      "Seraph" : null,
      "Snake" : "Kishin",
      "Tyrant" : null,
      "Vile" : null,
      "Wargod" : "Kishin",
      "Wilder" : null,
      "Yoma" : "Megami"
   },
   "Divine" : {
      "Avatar" : "Megami",
      "Avian" : "Snake",
      "Beast" : "Holy",
      "Brute" : "Yoma",
      "Deity" : "Megami",
      "Divine" : "Element",
      "Dragon" : "Megami",
      "Element" : "Divine",
      "Entity" : "Megami",
      "Fairy" : "Megami",
      "Fallen" : "Vile",
      "Femme" : "Beast",
      "Fiend" : "Vile",
      "Foul" : "Fairy",
      "Fury" : "Deity",
      "Genma" : "Megami",
      "Haunt" : "Jirae",
      "Holy" : "Fairy",
      "Jirae" : "Night",
      "Kishin" : "Vile",
      "Lady" : "Megami",
      "Megami" : "Holy",
      "Mitama" : "Divine",
      "Night" : "Snake",
      "Raptor" : "Foul",
      "Seraph" : "Megami",
      "Snake" : "Fairy",
      "Tyrant" : "Vile",
      "Vile" : "Fallen",
      "Wargod" : "Holy",
      "Wilder" : "Fallen",
      "Yoma" : "Snake"
   },
   "Dragon" : {
      "Avatar" : "Fury",
      "Avian" : "Fury",
      "Beast" : "Snake",
      "Brute" : "Night",
      "Deity" : null,
      "Divine" : "Megami",
      "Dragon" : null,
      "Element" : null,
      "Entity" : "Lady",
      "Fairy" : "Snake",
      "Fallen" : "Snake",
      "Femme" : "Night",
      "Fiend" : null,
      "Foul" : "Snake",
      "Fury" : null,
      "Genma" : "Holy",
      "Haunt" : null,
      "Holy" : "Snake",
      "Jirae" : "Kishin",
      "Kishin" : "Fury",
      "Lady" : null,
      "Megami" : "Avatar",
      "Mitama" : "Dragon",
      "Night" : "Femme",
      "Raptor" : null,
      "Seraph" : "Holy",
      "Snake" : "Lady",
      "Tyrant" : null,
      "Vile" : "Snake",
      "Wargod" : "Lady",
      "Wilder" : null,
      "Yoma" : "Avatar"
   },
   "Element" : {
      "Avatar" : null,
      "Avian" : null,
      "Beast" : "Beast",
      "Brute" : "Brute",
      "Deity" : "Deity",
      "Divine" : "Divine",
      "Dragon" : null,
      "Element" : "Mitama",
      "Entity" : null,
      "Fairy" : "Fairy",
      "Fallen" : "Fallen",
      "Femme" : "Femme",
      "Fiend" : null,
      "Foul" : "Foul",
      "Fury" : "Fury",
      "Genma" : null,
      "Haunt" : "Haunt",
      "Holy" : "Holy",
      "Jirae" : "Jirae",
      "Kishin" : "Kishin",
      "Lady" : "Lady",
      "Megami" : "Megami",
      "Mitama" : "Element",
      "Night" : "Night",
      "Raptor" : null,
      "Seraph" : null,
      "Snake" : "Snake",
      "Tyrant" : "Tyrant",
      "Vile" : "Vile",
      "Wargod" : null,
      "Wilder" : "Wilder",
      "Yoma" : "Yoma"
   },
   "Entity" : {
      "Avatar" : "Fury",
      "Avian" : "Deity",
      "Beast" : "Holy",
      "Brute" : "Fury",
      "Deity" : "Megami",
      "Divine" : "Megami",
      "Dragon" : "Lady",
      "Element" : null,
      "Entity" : null,
      "Fairy" : "Megami",
      "Fallen" : "Kishin",
      "Femme" : "Lady",
      "Fiend" : null,
      "Foul" : "Brute",
      "Fury" : "Lady",
      "Genma" : "Fury",
      "Haunt" : "Brute",
      "Holy" : "Kishin",
      "Jirae" : "Fury",
      "Kishin" : "Fury",
      "Lady" : "Fury",
      "Megami" : "Deity",
      "Mitama" : "Entity",
      "Night" : "Brute",
      "Raptor" : "Vile",
      "Seraph" : "Deity",
      "Snake" : "Fury",
      "Tyrant" : null,
      "Vile" : null,
      "Wargod" : "Fury",
      "Wilder" : "Brute",
      "Yoma" : "Megami"
   },
   "Fairy" : {
      "Avatar" : "Divine",
      "Avian" : "Night",
      "Beast" : "Divine",
      "Brute" : "Night",
      "Deity" : "Night",
      "Divine" : "Megami",
      "Dragon" : "Snake",
      "Element" : "Fairy",
      "Entity" : "Megami",
      "Fairy" : "Element",
      "Fallen" : "Yoma",
      "Femme" : "Haunt",
      "Fiend" : "Night",
      "Foul" : "Haunt",
      "Fury" : "Brute",
      "Genma" : null,
      "Haunt" : "Night",
      "Holy" : "Megami",
      "Jirae" : "Yoma",
      "Kishin" : "Brute",
      "Lady" : "Yoma",
      "Megami" : "Fallen",
      "Mitama" : "Fairy",
      "Night" : "Snake",
      "Raptor" : "Haunt",
      "Seraph" : "Holy",
      "Snake" : "Yoma",
      "Tyrant" : "Night",
      "Vile" : "Night",
      "Wargod" : null,
      "Wilder" : "Yoma",
      "Yoma" : "Holy"
   },
   "Fallen" : {
      "Avatar" : "Divine",
      "Avian" : "Snake",
      "Beast" : "Night",
      "Brute" : "Jirae",
      "Deity" : "Fury",
      "Divine" : "Vile",
      "Dragon" : "Snake",
      "Element" : "Fallen",
      "Entity" : "Kishin",
      "Fairy" : "Yoma",
      "Fallen" : "Element",
      "Femme" : "Wilder",
      "Fiend" : "Fury",
      "Foul" : "Vile",
      "Fury" : "Vile",
      "Genma" : "Lady",
      "Haunt" : "Night",
      "Holy" : "Beast",
      "Jirae" : "Brute",
      "Kishin" : "Night",
      "Lady" : "Fury",
      "Megami" : "Divine",
      "Mitama" : "Fallen",
      "Night" : "Haunt",
      "Raptor" : "Foul",
      "Seraph" : "Lady",
      "Snake" : "Beast",
      "Tyrant" : "Fury",
      "Vile" : "Brute",
      "Wargod" : "Lady",
      "Wilder" : "Night",
      "Yoma" : "Jirae"
   },
   "Femme" : {
      "Avatar" : "Kishin",
      "Avian" : "Brute",
      "Beast" : "Foul",
      "Brute" : "Beast",
      "Deity" : "Lady",
      "Divine" : "Beast",
      "Dragon" : "Night",
      "Element" : "Femme",
      "Entity" : "Lady",
      "Fairy" : "Haunt",
      "Fallen" : "Wilder",
      "Femme" : "Element",
      "Fiend" : "Lady",
      "Foul" : "Wilder",
      "Fury" : "Lady",
      "Genma" : "Night",
      "Haunt" : "Foul",
      "Holy" : "Lady",
      "Jirae" : "Wilder",
      "Kishin" : "Lady",
      "Lady" : "Kishin",
      "Megami" : "Fairy",
      "Mitama" : "Femme",
      "Night" : "Jirae",
      "Raptor" : "Foul",
      "Seraph" : null,
      "Snake" : "Kishin",
      "Tyrant" : "Lady",
      "Vile" : "Brute",
      "Wargod" : null,
      "Wilder" : "Fallen",
      "Yoma" : "Brute"
   },
   "Fiend" : {
      "Avatar" : null,
      "Avian" : null,
      "Beast" : "Night",
      "Brute" : "Haunt",
      "Deity" : null,
      "Divine" : "Vile",
      "Dragon" : null,
      "Element" : null,
      "Entity" : null,
      "Fairy" : "Night",
      "Fallen" : "Fury",
      "Femme" : "Lady",
      "Fiend" : null,
      "Foul" : "Haunt",
      "Fury" : "Deity",
      "Genma" : "Yoma",
      "Haunt" : "Foul",
      "Holy" : null,
      "Jirae" : "Wilder",
      "Kishin" : null,
      "Lady" : null,
      "Megami" : null,
      "Mitama" : "Fiend",
      "Night" : "Lady",
      "Raptor" : "Fury",
      "Seraph" : "Fallen",
      "Snake" : "Brute",
      "Tyrant" : null,
      "Vile" : "Fury",
      "Wargod" : null,
      "Wilder" : "Night",
      "Yoma" : "Night"
   },
   "Foul" : {
      "Avatar" : null,
      "Avian" : null,
      "Beast" : "Wilder",
      "Brute" : "Wilder",
      "Deity" : null,
      "Divine" : "Fairy",
      "Dragon" : "Snake",
      "Element" : "Foul",
      "Entity" : "Brute",
      "Fairy" : "Haunt",
      "Fallen" : "Vile",
      "Femme" : "Wilder",
      "Fiend" : "Haunt",
      "Foul" : null,
      "Fury" : null,
      "Genma" : null,
      "Haunt" : "Brute",
      "Holy" : null,
      "Jirae" : "Femme",
      "Kishin" : null,
      "Lady" : "Vile",
      "Megami" : null,
      "Mitama" : "Foul",
      "Night" : "Brute",
      "Raptor" : "Vile",
      "Seraph" : "Fallen",
      "Snake" : "Fallen",
      "Tyrant" : "Haunt",
      "Vile" : "Haunt",
      "Wargod" : null,
      "Wilder" : "Beast",
      "Yoma" : "Snake"
   },
   "Fury" : {
      "Avatar" : "Holy",
      "Avian" : "Kishin",
      "Beast" : "Avatar",
      "Brute" : "Lady",
      "Deity" : null,
      "Divine" : "Deity",
      "Dragon" : null,
      "Element" : "Fury",
      "Entity" : "Lady",
      "Fairy" : "Brute",
      "Fallen" : "Vile",
      "Femme" : "Lady",
      "Fiend" : "Deity",
      "Foul" : null,
      "Fury" : null,
      "Genma" : "Lady",
      "Haunt" : null,
      "Holy" : "Kishin",
      "Jirae" : "Femme",
      "Kishin" : "Lady",
      "Lady" : "Vile",
      "Megami" : "Deity",
      "Mitama" : "Fury",
      "Night" : "Lady",
      "Raptor" : "Tyrant",
      "Seraph" : "Vile",
      "Snake" : "Kishin",
      "Tyrant" : "Deity",
      "Vile" : "Tyrant",
      "Wargod" : "Deity",
      "Wilder" : null,
      "Yoma" : "Holy"
   },
   "Genma" : {
      "Avatar" : "Kishin",
      "Avian" : "Megami",
      "Beast" : "Fairy",
      "Brute" : "Divine",
      "Deity" : "Megami",
      "Divine" : "Megami",
      "Dragon" : "Holy",
      "Element" : null,
      "Entity" : "Fury",
      "Fairy" : null,
      "Fallen" : "Lady",
      "Femme" : "Night",
      "Fiend" : "Yoma",
      "Foul" : null,
      "Fury" : "Lady",
      "Genma" : null,
      "Haunt" : null,
      "Holy" : "Yoma",
      "Jirae" : "Lady",
      "Kishin" : "Megami",
      "Lady" : "Femme",
      "Megami" : "Divine",
      "Mitama" : "Genma",
      "Night" : "Holy",
      "Raptor" : "Lady",
      "Seraph" : "Megami",
      "Snake" : "Femme",
      "Tyrant" : "Yoma",
      "Vile" : "Yoma",
      "Wargod" : "Holy",
      "Wilder" : "Yoma",
      "Yoma" : null
   },
   "Haunt" : {
      "Avatar" : null,
      "Avian" : null,
      "Beast" : "Wilder",
      "Brute" : "Foul",
      "Deity" : null,
      "Divine" : "Jirae",
      "Dragon" : null,
      "Element" : "Haunt",
      "Entity" : "Brute",
      "Fairy" : "Night",
      "Fallen" : "Night",
      "Femme" : "Foul",
      "Fiend" : "Foul",
      "Foul" : "Brute",
      "Fury" : null,
      "Genma" : null,
      "Haunt" : null,
      "Holy" : null,
      "Jirae" : "Vile",
      "Kishin" : null,
      "Lady" : "Vile",
      "Megami" : null,
      "Mitama" : "Haunt",
      "Night" : "Yoma",
      "Raptor" : "Vile",
      "Seraph" : "Fallen",
      "Snake" : "Brute",
      "Tyrant" : "Foul",
      "Vile" : "Foul",
      "Wargod" : null,
      "Wilder" : "Jirae",
      "Yoma" : "Jirae"
   },
   "Holy" : {
      "Avatar" : "Megami",
      "Avian" : "Lady",
      "Beast" : "Avatar",
      "Brute" : "Femme",
      "Deity" : "Megami",
      "Divine" : "Fairy",
      "Dragon" : "Snake",
      "Element" : "Holy",
      "Entity" : "Kishin",
      "Fairy" : "Megami",
      "Fallen" : "Beast",
      "Femme" : "Lady",
      "Fiend" : null,
      "Foul" : null,
      "Fury" : "Kishin",
      "Genma" : "Yoma",
      "Haunt" : null,
      "Holy" : "Element",
      "Jirae" : "Beast",
      "Kishin" : "Lady",
      "Lady" : "Avatar",
      "Megami" : "Divine",
      "Mitama" : "Holy",
      "Night" : "Fairy",
      "Raptor" : "Wilder",
      "Seraph" : "Divine",
      "Snake" : "Kishin",
      "Tyrant" : null,
      "Vile" : null,
      "Wargod" : "Kishin",
      "Wilder" : null,
      "Yoma" : "Divine"
   },
   "Jirae" : {
      "Avatar" : "Kishin",
      "Avian" : "Kishin",
      "Beast" : "Yoma",
      "Brute" : "Fairy",
      "Deity" : "Brute",
      "Divine" : "Night",
      "Dragon" : "Kishin",
      "Element" : "Jirae",
      "Entity" : "Fury",
      "Fairy" : "Yoma",
      "Fallen" : "Brute",
      "Femme" : "Wilder",
      "Fiend" : "Wilder",
      "Foul" : "Femme",
      "Fury" : "Femme",
      "Genma" : "Lady",
      "Haunt" : "Vile",
      "Holy" : "Beast",
      "Jirae" : "Element",
      "Kishin" : "Snake",
      "Lady" : "Beast",
      "Megami" : "Lady",
      "Mitama" : "Jirae",
      "Night" : "Foul",
      "Raptor" : "Foul",
      "Seraph" : null,
      "Snake" : "Fallen",
      "Tyrant" : "Wilder",
      "Vile" : "Haunt",
      "Wargod" : "Kishin",
      "Wilder" : "Brute",
      "Yoma" : "Beast"
   },
   "Kishin" : {
      "Avatar" : "Holy",
      "Avian" : "Lady",
      "Beast" : "Holy",
      "Brute" : "Snake",
      "Deity" : "Fury",
      "Divine" : "Vile",
      "Dragon" : "Fury",
      "Element" : "Kishin",
      "Entity" : "Fury",
      "Fairy" : "Brute",
      "Fallen" : "Night",
      "Femme" : "Lady",
      "Fiend" : null,
      "Foul" : null,
      "Fury" : "Lady",
      "Genma" : "Megami",
      "Haunt" : null,
      "Holy" : "Lady",
      "Jirae" : "Snake",
      "Kishin" : null,
      "Lady" : "Fury",
      "Megami" : "Lady",
      "Mitama" : "Kishin",
      "Night" : "Femme",
      "Raptor" : "Tyrant",
      "Seraph" : "Divine",
      "Snake" : "Femme",
      "Tyrant" : null,
      "Vile" : null,
      "Wargod" : "Fury",
      "Wilder" : null,
      "Yoma" : "Femme"
   },
   "Lady" : {
      "Avatar" : "Fury",
      "Avian" : null,
      "Beast" : "Snake",
      "Brute" : "Fury",
      "Deity" : null,
      "Divine" : "Megami",
      "Dragon" : null,
      "Element" : "Lady",
      "Entity" : "Fury",
      "Fairy" : "Yoma",
      "Fallen" : "Fury",
      "Femme" : "Kishin",
      "Fiend" : null,
      "Foul" : "Vile",
      "Fury" : "Vile",
      "Genma" : "Femme",
      "Haunt" : "Vile",
      "Holy" : "Avatar",
      "Jirae" : "Beast",
      "Kishin" : "Fury",
      "Lady" : null,
      "Megami" : "Fury",
      "Mitama" : "Lady",
      "Night" : "Kishin",
      "Raptor" : "Kishin",
      "Seraph" : "Deity",
      "Snake" : "Femme",
      "Tyrant" : null,
      "Vile" : null,
      "Wargod" : "Kishin",
      "Wilder" : "Haunt",
      "Yoma" : "Night"
   },
   "Megami" : {
      "Avatar" : "Deity",
      "Avian" : "Deity",
      "Beast" : "Holy",
      "Brute" : "Femme",
      "Deity" : null,
      "Divine" : "Holy",
      "Dragon" : "Avatar",
      "Element" : "Megami",
      "Entity" : "Deity",
      "Fairy" : "Fallen",
      "Fallen" : "Divine",
      "Femme" : "Fairy",
      "Fiend" : null,
      "Foul" : null,
      "Fury" : "Deity",
      "Genma" : "Divine",
      "Haunt" : null,
      "Holy" : "Divine",
      "Jirae" : "Lady",
      "Kishin" : "Lady",
      "Lady" : "Fury",
      "Megami" : null,
      "Mitama" : "Megami",
      "Night" : "Fallen",
      "Raptor" : "Tyrant",
      "Seraph" : "Deity",
      "Snake" : "Fairy",
      "Tyrant" : null,
      "Vile" : "Fury",
      "Wargod" : "Deity",
      "Wilder" : "Vile",
      "Yoma" : "Kishin"
   },
   "Mitama" : {
      "Avatar" : "Avatar",
      "Avian" : "Avian",
      "Beast" : "Beast",
      "Brute" : "Brute",
      "Deity" : "Deity",
      "Divine" : "Divine",
      "Dragon" : "Dragon",
      "Element" : "Element",
      "Entity" : "Entity",
      "Fairy" : "Fairy",
      "Fallen" : "Fallen",
      "Femme" : "Femme",
      "Fiend" : "Fiend",
      "Foul" : "Foul",
      "Fury" : "Fury",
      "Genma" : "Genma",
      "Haunt" : "Haunt",
      "Holy" : "Holy",
      "Jirae" : "Jirae",
      "Kishin" : "Kishin",
      "Lady" : "Lady",
      "Megami" : "Megami",
      "Mitama" : "Mitama",
      "Night" : "Night",
      "Raptor" : "Raptor",
      "Seraph" : "Seraph",
      "Snake" : "Snake",
      "Tyrant" : "Tyrant",
      "Vile" : "Vile",
      "Wargod" : "Wargod",
      "Wilder" : "Wilder",
      "Yoma" : "Yoma"
   },
   "Night" : {
      "Avatar" : "Holy",
      "Avian" : "Femme",
      "Beast" : "Fairy",
      "Brute" : "Kishin",
      "Deity" : "Vile",
      "Divine" : "Snake",
      "Dragon" : "Femme",
      "Element" : "Night",
      "Entity" : "Brute",
      "Fairy" : "Snake",
      "Fallen" : "Haunt",
      "Femme" : "Jirae",
      "Fiend" : "Lady",
      "Foul" : "Brute",
      "Fury" : "Lady",
      "Genma" : "Holy",
      "Haunt" : "Yoma",
      "Holy" : "Fairy",
      "Jirae" : "Foul",
      "Kishin" : "Femme",
      "Lady" : "Kishin",
      "Megami" : "Fallen",
      "Mitama" : "Night",
      "Night" : "Element",
      "Raptor" : "Vile",
      "Seraph" : "Fallen",
      "Snake" : "Fallen",
      "Tyrant" : "Lady",
      "Vile" : "Lady",
      "Wargod" : null,
      "Wilder" : "Beast",
      "Yoma" : "Divine"
   },
   "Raptor" : {
      "Avatar" : "Wilder",
      "Avian" : "Megami",
      "Beast" : "Wilder",
      "Brute" : "Fury",
      "Deity" : "Tyrant",
      "Divine" : "Foul",
      "Dragon" : null,
      "Element" : null,
      "Entity" : "Vile",
      "Fairy" : "Haunt",
      "Fallen" : "Foul",
      "Femme" : "Foul",
      "Fiend" : "Fury",
      "Foul" : "Vile",
      "Fury" : "Tyrant",
      "Genma" : "Lady",
      "Haunt" : "Vile",
      "Holy" : "Wilder",
      "Jirae" : "Foul",
      "Kishin" : "Tyrant",
      "Lady" : "Kishin",
      "Megami" : "Tyrant",
      "Mitama" : "Raptor",
      "Night" : "Vile",
      "Raptor" : null,
      "Seraph" : null,
      "Snake" : "Foul",
      "Tyrant" : "Fury",
      "Vile" : "Fury",
      "Wargod" : null,
      "Wilder" : "Vile",
      "Yoma" : "Haunt"
   },
   "Seraph" : {
      "Avatar" : "Deity",
      "Avian" : "Megami",
      "Beast" : null,
      "Brute" : null,
      "Deity" : null,
      "Divine" : "Megami",
      "Dragon" : "Holy",
      "Element" : null,
      "Entity" : "Deity",
      "Fairy" : "Holy",
      "Fallen" : "Lady",
      "Femme" : null,
      "Fiend" : "Fallen",
      "Foul" : "Fallen",
      "Fury" : "Vile",
      "Genma" : "Megami",
      "Haunt" : "Fallen",
      "Holy" : "Divine",
      "Jirae" : null,
      "Kishin" : "Divine",
      "Lady" : "Deity",
      "Megami" : "Deity",
      "Mitama" : "Seraph",
      "Night" : "Fallen",
      "Raptor" : null,
      "Seraph" : "Element",
      "Snake" : null,
      "Tyrant" : "Fallen",
      "Vile" : "Divine",
      "Wargod" : "Kishin",
      "Wilder" : null,
      "Yoma" : "Megami"
   },
   "Snake" : {
      "Avatar" : "Lady",
      "Avian" : "Kishin",
      "Beast" : "Brute",
      "Brute" : "Beast",
      "Deity" : "Kishin",
      "Divine" : "Fairy",
      "Dragon" : "Lady",
      "Element" : "Snake",
      "Entity" : "Fury",
      "Fairy" : "Yoma",
      "Fallen" : "Beast",
      "Femme" : "Kishin",
      "Fiend" : "Brute",
      "Foul" : "Fallen",
      "Fury" : "Kishin",
      "Genma" : "Femme",
      "Haunt" : "Brute",
      "Holy" : "Kishin",
      "Jirae" : "Fallen",
      "Kishin" : "Femme",
      "Lady" : "Femme",
      "Megami" : "Fairy",
      "Mitama" : "Snake",
      "Night" : "Fallen",
      "Raptor" : "Foul",
      "Seraph" : null,
      "Snake" : "Element",
      "Tyrant" : "Brute",
      "Vile" : "Kishin",
      "Wargod" : "Kishin",
      "Wilder" : "Night",
      "Yoma" : "Night"
   },
   "Tyrant" : {
      "Avatar" : null,
      "Avian" : null,
      "Beast" : "Night",
      "Brute" : "Haunt",
      "Deity" : null,
      "Divine" : "Vile",
      "Dragon" : null,
      "Element" : "Tyrant",
      "Entity" : null,
      "Fairy" : "Night",
      "Fallen" : "Fury",
      "Femme" : "Lady",
      "Fiend" : null,
      "Foul" : "Haunt",
      "Fury" : "Deity",
      "Genma" : "Yoma",
      "Haunt" : "Foul",
      "Holy" : null,
      "Jirae" : "Wilder",
      "Kishin" : null,
      "Lady" : null,
      "Megami" : null,
      "Mitama" : "Tyrant",
      "Night" : "Lady",
      "Raptor" : "Fury",
      "Seraph" : "Fallen",
      "Snake" : "Brute",
      "Tyrant" : null,
      "Vile" : "Fury",
      "Wargod" : null,
      "Wilder" : "Night",
      "Yoma" : "Night"
   },
   "Vile" : {
      "Avatar" : "Deity",
      "Avian" : null,
      "Beast" : "Foul",
      "Brute" : "Haunt",
      "Deity" : null,
      "Divine" : "Fallen",
      "Dragon" : "Snake",
      "Element" : "Vile",
      "Entity" : null,
      "Fairy" : "Night",
      "Fallen" : "Brute",
      "Femme" : "Brute",
      "Fiend" : "Fury",
      "Foul" : "Haunt",
      "Fury" : "Tyrant",
      "Genma" : "Yoma",
      "Haunt" : "Foul",
      "Holy" : null,
      "Jirae" : "Haunt",
      "Kishin" : null,
      "Lady" : null,
      "Megami" : "Fury",
      "Mitama" : "Vile",
      "Night" : "Lady",
      "Raptor" : "Fury",
      "Seraph" : "Divine",
      "Snake" : "Kishin",
      "Tyrant" : "Fury",
      "Vile" : null,
      "Wargod" : "Kishin",
      "Wilder" : "Foul",
      "Yoma" : "Jirae"
   },
   "Wargod" : {
      "Avatar" : "Deity",
      "Avian" : "Kishin",
      "Beast" : "Holy",
      "Brute" : null,
      "Deity" : "Kishin",
      "Divine" : "Holy",
      "Dragon" : "Lady",
      "Element" : null,
      "Entity" : "Fury",
      "Fairy" : null,
      "Fallen" : "Lady",
      "Femme" : null,
      "Fiend" : null,
      "Foul" : null,
      "Fury" : "Deity",
      "Genma" : "Holy",
      "Haunt" : null,
      "Holy" : "Kishin",
      "Jirae" : "Kishin",
      "Kishin" : "Fury",
      "Lady" : "Kishin",
      "Megami" : "Deity",
      "Mitama" : "Wargod",
      "Night" : null,
      "Raptor" : null,
      "Seraph" : "Kishin",
      "Snake" : "Kishin",
      "Tyrant" : null,
      "Vile" : "Kishin",
      "Wargod" : null,
      "Wilder" : null,
      "Yoma" : null
   },
   "Wilder" : {
      "Avatar" : null,
      "Avian" : null,
      "Beast" : "Jirae",
      "Brute" : "Fairy",
      "Deity" : null,
      "Divine" : "Fallen",
      "Dragon" : null,
      "Element" : "Wilder",
      "Entity" : "Brute",
      "Fairy" : "Yoma",
      "Fallen" : "Night",
      "Femme" : "Fallen",
      "Fiend" : "Night",
      "Foul" : "Beast",
      "Fury" : null,
      "Genma" : "Yoma",
      "Haunt" : "Jirae",
      "Holy" : null,
      "Jirae" : "Brute",
      "Kishin" : null,
      "Lady" : "Haunt",
      "Megami" : "Vile",
      "Mitama" : "Wilder",
      "Night" : "Beast",
      "Raptor" : "Vile",
      "Seraph" : null,
      "Snake" : "Night",
      "Tyrant" : "Night",
      "Vile" : "Foul",
      "Wargod" : null,
      "Wilder" : "Element",
      "Yoma" : "Beast"
   },
   "Yoma" : {
      "Avatar" : "Divine",
      "Avian" : "Night",
      "Beast" : "Fallen",
      "Brute" : "Femme",
      "Deity" : "Megami",
      "Divine" : "Snake",
      "Dragon" : "Avatar",
      "Element" : "Yoma",
      "Entity" : "Megami",
      "Fairy" : "Holy",
      "Fallen" : "Jirae",
      "Femme" : "Brute",
      "Fiend" : "Night",
      "Foul" : "Snake",
      "Fury" : "Holy",
      "Genma" : null,
      "Haunt" : "Jirae",
      "Holy" : "Divine",
      "Jirae" : "Beast",
      "Kishin" : "Femme",
      "Lady" : "Night",
      "Megami" : "Kishin",
      "Mitama" : "Yoma",
      "Night" : "Divine",
      "Raptor" : "Haunt",
      "Seraph" : "Megami",
      "Snake" : "Night",
      "Tyrant" : "Night",
      "Vile" : "Jirae",
      "Wargod" : null,
      "Wilder" : "Beast",
      "Yoma" : "Element"
   }
}
