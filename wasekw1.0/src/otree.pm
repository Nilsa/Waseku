#!usr/bin/env perl

package otree;
use strict;
use warnings;
use node;
our @ISA = qw( node );

sub new {
    my $class = shift;

    my $self = {
        _ont_tree => shift,
        _def_list => shift,
        _fig_path => shift,
    }
    bless $self, $class;
    return $self;
}

sub empty_ont_tree {
    my ($_ont_tree) = @_;

    return $_ont_tree->{_ont_tree} = {};
}

sub empty_def_list {
    my ($_ont_tree) = @_;

    return $_ont_tree->{_def_list} = @_;
}

sub empty_fig_path {
    my ($_ont_tree) = @_;

    return $_ont_tree->{_fig_path} = "";
}

sub read_ont_tree {
    my ($_ont_tree) = @_;

    my @tmp;
    foreach (keys $_ont_tree->{_ont_tree}) {
        push @tmp, $_;
    }

    return @tmp;
    undef @tmp;
}
