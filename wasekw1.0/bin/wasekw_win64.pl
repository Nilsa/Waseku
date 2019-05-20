#! C:/Perl64/lib/

###############################################################################
#                                                                             #
#    wasekw1.0 is an interactive tool for ontogenic trees construction        #
#    from hierarchical *csv and *txt files. It was programmed in Perl 5       #
#    using Tkx::tk___treeview and hash tables as building engines for the     #
#    trees set up.                                                            #
#                                                                             #
#    Copyright (C) 2018 Criado-Sutti. Emilio and Sarmiento. Nilsa,            #
#    Facultad de Ciencias Exactas, Departamento de Fisica,                    #
#    Universidad Nacional de Salta.                                           #
#                                                                             #
#    This program is free software: you can redistribute it and/or modify     #
#    it under the terms of the GNU General Public License as published by     #
#    the Free Software Foundation, either version 3 of the License, or        #
#    (at your option) any later version.                                      #
#                                                                             #
#    This program is distributed in the hope that it will be useful,          #
#    but WITHOUT ANY WARRANTY; without even the implied warranty of           #
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            #
#    GNU General Public License for more details.                             #
#                                                                             #
#    You should have received a copy of the GNU General Public License        #
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.    #
#                                                                             #
#    Version: 1.0                                                             #
#    Interpreters: Perl >= 5                                                  #
#    File EXT: *txt, *csv, *json.                                             #
#    e-mail: criadosutti@uni-potsdam.de,nilsa@ututo.org                       #
#    ref: https://tkdocs.com/tutorial/                                        #
#                                                                             #
###############################################################################

use strict;
use warnings;
use lib 'lib';
use utf8;

use Data::Dumper;
use Tie::IxHash::Easy;
use Storable;
use Tk;
use Tk::Tree;
use Tkx;
use JSON;
use JSON::Parse;
use List::MoreUtils ':all';

binmode STDOUT, ":utf8";

our $VERSION = 1.0;
(my $progname = $0) =~ s/(.+)\.[^.]+$/$1/;
my $NW_AQUA = Tkx::tk_windowingsystem() eq "aqua";

# Create Main Frame
my $main = Tkx::widget->new('.');
$main->g_wm_geometry("300x500");
$main->configure(-menu => mk_menu($main));
$main->g_wm_title("WASEKW 1.0");

# Setting Icon
#Tkx::package_require("Img");
#my $img = Tkx::image_create_photo(-file => 'logo.png');
#$main->g_wm_iconphoto($img);

# Create Tree
my $tree = $main->new_ttk__treeview;

# Browse Subroutine
sub browse{
    return Tkx::tk___getOpenFile(-parent => $main);
}

# Figure Label
sub figure_menu{
    my ($main, $figure_path) = @_;
    my $figure = $main->new_toplevel;
    $figure->g_wm_title("WkW Picture");
    $figure->g_wm_geometry("250x300+450+125");
    #$figure->g_wm_resizable(1,1);
    #$figure->g_wm_iconphoto($img);
    show_fig($figure, $figure_path);
}

# Mash Menu
sub mash_menu{
    my ($main) = @_;
    my $path0;
    my $path1;
    my $mash = $main->new_toplevel;
    $mash->g_wm_title("WKW Mash");
    $mash->g_wm_geometry("400x200+450+457");
    #$mash->g_wm_iconphoto($img);
    my $label = $mash->new_ttk__frame();
    my $brs0 = $label->new_ttk__button(-text => "Browse Tree 0", -command => sub { $path0 = browse });
    my $brs1 = $label->new_ttk__button(-text => "Browse Tree 1", -command => sub { $path1 = browse });
    my $tree0_path = $label->new_ttk__entry(-textvariable => $path0);
    $label->g_pack();
    $label->g_raise();
    $brs0->g_pack();
    $brs1->g_pack();
    $tree0_path->g_pack();
}

# Setting Columns

# Global Variables
my $filename = "";
my $json_filename = "";
my $def_filename = "";
my $figure_path = "";
my %hash_;
my @keyring_;

# Structure Constructor
sub hash_creator{
    my ($_filename) = @_;
    my $contents = do { local(@ARGV, $/) = $_filename; <> } or return;
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

# Tree Printer
sub tree_printer{
    my ($_hash, $_parent, $_depth)= @_;
    foreach my $key (keys %$_hash){
        my $id_0 = $tree->insert($_parent, $_depth, -id => "$key", -text => "$key");
        if (ref($_hash->{$key}) eq 'HASH'){
            $_depth += 1;
            tree_printer($_hash->{$key}, $id_0, $_depth);
        }
    }
    return;
}

# Tree Creator
sub tree_creator{
    my ($_self, $_name) = @_;
    my %new_hash = hash_creator($_name);
    tree_printer(\%new_hash, "", 0);
    undef %new_hash;
    return;
}

# Tree Cleaner
sub tree_cleaner{
    if ($filename ne ""){
        %hash_ = hash_creator($filename);
    }
    else {
        %hash_ = open_tree($json_filename);
    }
    foreach (keys %hash_){ $tree->delete($_); }
    undef %hash_;
    return;
}

# Insert Definitions
sub list_converter{
    open PFILE, '<', $_;
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

sub get_value{
    my $value = $tree->item($_, -value);
    return $value;
}

sub get_focused{
    my $id = $tree->selection();
    $id =~ s/[\{\$\}]+//gi;
    return $id;
}

sub show_def{
    my $id = $tree->selection();
    $id =~ s/[\{\$\}]+//gi;
    my $value = $tree->item($id, -value);
    Tkx::tk___messageBox(-message => $value, -title => "WkW Info", -icon => "info");
    return;
}

sub insert_def{
    my ($_file_list, $_filename) = @_;
    my @list = list_converter($_file_list);
    my %_hash = hash_creator($_filename);
    nested_hash_read(\%_hash);
    my @combi = zip6 @keyring_, @list;
    foreach (@combi){
        $tree->item($_->[0], -value => $_->[1], -tags => "ttk simple");
    }
    undef @keyring_;
    undef %_hash;
    undef @list;
    return;
}

sub nested_hash_read{
    my @key_list;
    foreach my $key (keys %$_){
        push @keyring_, $key;
        if (ref($_nested_hash->{$key}) eq 'HASH'){
            nested_hash_read($_nested_hash->{$key});
        }
    }
    @key_list = @keyring_;
    return @key_list;
}

# Insert Figures
sub insert_fig{
    my $dir = './figs';
    opendir(FDIR, $dir) or die $!;
    while ( readdir(FDIR) ){
        next unless ($_ =~ m/\.jpg$/);
        my @i = split /\./, $_;
        my $img_i = Tkx::image_create_photo(-file => "./figs/$_");
        $tree->item($i[0], -image => $img_i);
    }
    closedir FDIR;
    return;
}

sub add_figure_path{
    $figure_path = Tkx::tk___chooseDirectory(-parent => $main);
    return;
}

sub error_fig_not_found{
    Tkx::tk___messageBox(-message => "$_ figure doesn't found", -title => "WkW Error", -icon => "error");
    return;
}

sub search_fig{
    my ($_dir_name, $_id) = @_;
    my $name;
    opendir(FDIR, $_dir_name) or die $!;
    while (readdir(FDIR)){
        ($name = $_) =~ s/(.+)\.[^.]+$/$1/;
        if ($name eq $_id) { return $_; }
        #else { return ""; }
    }
    closedir FDIR;
}

sub error_path_fig{
    if ($_ eq ""){
        Tkx::tk___messageBox(-message => "You didn't set the figure's path", -title => "WkW Error", -icon => "error");
        return 0;
    }
    else { return 1; }
}

sub show_fig{	
    my ($figure, $path_dir) = @_;
    my $label = $figure->new_ttk__label();
    if (error_path_fig($path_dir) == 1){
        my $id = $tree->selection();
        my $name = search_fig($path_dir, $id);
        #if ( $name eq "" ) { error_fig_not_found($id); }
        my $photo = Tkx::image_create_photo(-file => "$path_dir"."$name");
        $label->configure(-image => $photo);
    }
    $label->g_pack();
    $label->g_raise();
    return;
}

sub show_fig_bind{
    my ($main, $figure_path) = @_;
    $main->g_bind("<Shift-1>", sub {figure_menu($main, $figure_path);});
}

# Add Node
#sub add_node{
#    my ($id) = @_;

# About Button
sub about{
    Tkx::tk___messageBox(-message => "wasekw1.0 is an interactive tool for ontogenic-like trees construction from hierarchical *csv and *txt files. It was programmed in Perl 5 using Tkx::tk___treeview and hash tables as building engines for the trees set up.", -icon => "info");
}

# Manual Button
sub manual{
    system "adobe ./man.md";
}

# Check if Item Exists
sub item_check{
    my $item = $tree->exist($_);
    print $item."\n"; 
}

# Save Tree
sub save_tree{
    my $path = "~\SRC\Waseku\wasekw1.0\temp\";
    my @name = split(/\//, $_);
    my @name_i = split(/\./, pop @name);
    my %new_hash = hash_creator($_);
    open my $fh, ">", $path.$name_i[0]."\.json";
    print $fh encode_json(\%new_hash);
    close $fh;
    return;
}

# Open Saved JSON Tree
sub open_tree{
    open my $PFILE, "<", $_;
    my $json = <$PFILE>;
    my $data = decode_json($json);
    close $PFILE;
    return %$data;
}

# Insert Hash to Tree
sub hash_to_tree{
    tree_printer(\%$_, "", 0);
    return;
}

# Hash to Tree
sub h_t_t{
    $json_filename = Tkx::tk___getOpenFile(-parent => $main); 
    my %old_hash = open_tree($json_filename); 
    hash_to_tree(\%old_hash);
    return;
}

# Mash
sub compare_value_list{
    my ($_value, $_list) = @_;
    foreach (@$_list){
        if ($_value eq $_){ return $_; }
    }
    return "";
}

sub compare_list_list{
    my ($_list_0, $_list_1) = @_;
    my @_result;
    foreach (@$_list_0){
        push @_result, compare_value_list($_, $_list_1);
    }
    return @_result;
}

sub compare_trees{
    my ($_tree_0, $_tree_1) = @_;
    my @keys_0 = nested_hash_read(%$_tree_0);
    my @keys_1 = nested_hash_read(%$_tree_1);
    my @shared_con = compare_list_list(@keys_0, @keys_1);
    print Dumper @shared_con;
    return;
}

# Menu Maker
sub mk_menu {
    my $main = shift;
    my $menu = $main->new_menu;

    my $file = $menu->new_menu(
        -tearoff => 0,
    );
    my $trees = $menu->new_menu(
        -tearoff => 0,
    );
    my $widgets = $menu->new_menu(
        -tearoff => 0,
    );
    my $show = $menu->new_menu(
        -tearoff => 0,
    );
    $menu->add_cascade(
        -label => "File",
        -underline => 0,
        -menu => $file,
    );
    $menu->add_cascade(
        -label => "Trees",
        -underline => 0,
        -menu => $trees,
    );
    $file->add_command(
        -label => "Open File",
        -underline => 0,
        -command => sub { $filename = Tkx::tk___getOpenFile(-parent => $main) },
    );
    $file->add_command(
        -label => "Exit",
        -underline => 1,
        -command => [\&Tkx::destroy, $main],
    ) unless $NW_AQUA;

    my $help = $menu->new_menu(
        -name => "help",
        -tearoff => 0,
    );
    $trees->add_command(
        -label => "Create New Tree",
        -underline => 0,
        -accelerator => "Ctrl+N",
        -command => sub { tree_creator($main, $filename) },
    );
    $trees->add_command(
        -label => "Save Tree",
        -underline => 1,
        -accelerator => "Ctrl+S",
        -command => sub { save_tree($filename) },
    );
    $trees->add_command(
        -label => "Open Tree",
        -underline => 2,
        -accelerator => "Ctrl+O",
        -command => sub { h_t_t() },
    );
    $trees->add_command(
        -label => "Clean Tree",
        -underline => 3,
        -accelerator => "Ctrl+C",
        -command => sub { tree_cleaner() },
    );
    $trees->add_command(
        -label => "Print ID",
        -underline => 4,
        -command => sub { print get_focused()."\n" },
    );
    $menu->add_cascade(
        -label => "Widgets",
        -underline => 0,
        -menu => $widgets,
    );
    $widgets->add_command(
        -label => "Add Definition",
        -underline => 0,
        -command => sub { $def_filename = Tkx::tk___getOpenFile(-parent => $main); insert_def($def_filename, $filename) },
    );
    $widgets->add_command(
        -label => "Add Figures Path",
        -underline => 1,
        -command => sub { add_figure_path() },
    );
    #$widgets->add_command(
    #    -label => "Mesh",
    #    -underline => 2,
    #    -command => sub { mash_menu($main) },
    #);
    $menu->add_cascade(
        -label => "Show",
        -underline => 0,
        -menu => $show,
    );
    $show->add_command(
        -label => "Show Figure",
        -underline => 0,
        -command => sub { figure_menu($main, $figure_path); },
    );
    $menu->add_cascade(
        -label => "Help",
        -underline => 0,
        -menu => $help,
    );
    $help->add_command(
        -label => "\u$progname Manual",
        -command => sub { manual() },
    );
        
    my $about_menu = $help;
    if ($NW_AQUA) {
        $about_menu = $menu->new_menu(
            -name => "camel",
        );
        $menu->add_cascade(
            -menu => $about_menu,
        );
     }
     $about_menu->add_command(
         -label => "About \u$progname",
         -command => sub { about() },
     );
     
     return $menu;
}

sub main{
    my ($main) = @_;
    show_fig_bind($main, $figure_path);
    $tree->tag_bind("ttk", "<Alt-1>", sub{ show_def() });
    #$tree->g_bind("<Tab-1>", sub{ show_fig($figure_path) });
    $tree->g_pack(-expand => 1, -fill => 'both');
    Tkx::MainLoop();
}

main($main);
