#!usr/bin/env perl

package node;

sub new {
    my $class = shift;

    my $self = {
        _name        => shift,
        _def         => shift,
        _path_to_fig => shift,
        _father_id   => shift,
        _childen_ids => shift,
    }
    bless $self, $class;
    return $self;
}

sub set_name {
    my ( $self, $name ) = @_;
    $self->{_name} = $name if defined($name);
    return $self->{_name};
}

sub set_def {
    my ( $self, $def ) = @_;
    $self->{_def} = $def if defined($def);
    return $self->{_def};
}

sub set_path_to_fig {
    my ( $self, $path ) = @_;
    $self->{_path_to_fig} = $path if defined($path);
    return $self->{_path_to_fig};
}

sub get_name {
    my ( $self ) = @_;
    return $self->{_name};
}

sub get_def {
    my ( $self ) = @_;
    return $self->{_def};
}

sub get_father {
    my ( $self ) = @_;
    return $self->{_father_id};
}

sub get_children {
    my ( $self ) = @_;
    return $self->{_children_ids};
}

sub create_root {
    my ( $self, $name ) = @_;
    set_name( $self, $name );
    $self->{_father_id} = undef;
    return $self;
}

sub destroy_node {
    my ( $self ) = @_;
    $self->{_name} = undef;
    $self->{_def} = undef;
    $self->{_path_to_fig} = undef;
    return $self;
}
