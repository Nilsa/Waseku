#!usr/bin/env perl

package otree;
use strict;
use warnings;
use Tie::IxHash::Easy;

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
    return $_ont_tree->{_ont_tree} = %_;
}

sub empty_def_list {
    my ($_ont_tree) = @_;
    return $_ont_tree->{_def_list} = @_;
}

sub empty_fig_path {
    my ($_ont_tree) = @_;
    return $_ont_tree->{_fig_path} = "";
}

sub hash_creator{
    my ($fh) = @_;
    my $contents = do { local(@ARGV, $/) = $fh; <> } or return;
    my @lines = split '\n', $contents;
    my @stack;
    tie my %hash, 'Tie::IxHash::Easy';
    push @stack, \%hash;
    foreach(@lines){
        chomp;
        s/^(\t*)//;
        splice @stack, length($1)+1;
        push @stack, $stack[$#stack]->{$_} = {};
    }
    return %hash;
}

sub list_converter{
    my ($fh) = @_;
    open PFILE, '<', $fh;
    local $/ = '##';
    my @paragraph;
    while (<PFILE>){
        chomp;
        s/[\$(\n*)]//;
        push @paragraph, "$_";
    }
    close PFILE;
    return @paragraph;
}


sub populate_ont_tree {
    my ($self, $filename) = @_;

    my %tmp = hash_creator($filename);
    $self->{_ont_tree} = %tmp if defined(%tmp);
    return $self->{_ont_tree};
    undef %tmp;
}

sub insert_def_list {
    my ($self, $filename) = @_;

    my @tmp = list_converter($filename);
    $self->{_def_list} = @tmp if defined(@tmp);
    return $self->{_def_list};
    undef @tmp;
}

sub set_fig_path {
    my ($self, $figpath) = @_;

    $self->{_fig_path} = $figpath if defined($figpath);
    return $self->{_fig_path};
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
