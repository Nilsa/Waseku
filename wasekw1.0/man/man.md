% WASEKU 1.0 

# Introduction

waseku is an interactive tool for ontogenies development based on discipline knowledge. Ontogenies are presented in a treeview cascade format constructed using hierarchical *csv* files where each concept represent an entity (or node) and *txt* files where the entities properties are stored. The hierarchy in the *csv* file is stablished by **tabs**, also used as field separators.

It was programmed in Perl 5 using [tcl-tk](https://www.tcl.tk/man/tcl/TkCmd/ttk_treeview.htm#M27) **Tkx::tk___treeview** and hash tables as building engines for the trees set up. 

# Getting Started

## Installation

### Linux 64

Open a terminal pompt. Log as superuser. Dive trought wasekw folders to wasekw1.0/installers and run

```console
~/src/Wasekw/wasekw1.0/installers$ make
```

### Windows 64

Dive trought wasekw folders down to */wasekw1.0/installers*. If you don't have Perl installed already, open a MS-DOS pompt and run

```console
:\> ppm install active-perl
```
then run

```
:\> perl install_windows64.pl
```
If your not familiar with MS-DOS, just double click *install_windows64.pl*.

# Constrcuting the *csv files

The *csv* files will result in the ontology spine once wasekw processed the nodes. 
The hierarchical structure of the in-files is stablished by tabs, resulting in a treeview cascade contained in a grided frame (text file). For *wasekw* work properly no tab or spaces has to exist after the text (node) is writen down. In case of having N concepts the tree will look like:

**Example 1**
```text_editor
entity 0
	entity 1
	entity 2
		entity 3
	entity 4
		entity 5
			entity 6
		entity 7
        .
        .
        .
        entity N-1
```

once you ended, save the file as 'filename.csv' choosing *tab* as field separator.

## Introducing the definitions

### The definitions *txt* file

The file must be constructed as follows

```text_editor
definition 0
##
definition 2
##
definition 3
##
.
.
.
definition N-1
##
```



### Add definitions

Once you have your definitions file ready, go to the "widgets" menu at *wasekw* main menu bar, select "Add Definitions"
and choose your definitions file.

### Viewing the definitions

To see the definition related to a node press "Alt" + click "Mouse Left". A popup message have to appear.

## Viewing the figures

### The "figures" folder

The figure folder must contain all the figures related to the tree, named same as the node appear on the tree.

**Example 2**
```text_editor
entity 0           ------> entity 0.*png,*jpg,*gif
	entity 1   ------> entity 1.*png,*jpg,*gif
	entity 2   ------> entity 2.*png,*jpg,*gif
	.
	.
	.
	entity N-1 ------> entity N-1.*png,*jpg,*gif
```

### Add figures path

Go to wasekw main menu bar, press "Widgets" button, and choose "Add Figures Path", then set the path to your figure's folder.

### View

To display the figures in the top level at the right side of wasekw main frame, go to "Show" in the main menu bar and press "Show Figure".

# Saving the Trees

If you to save your tree, go to "Trees" button and select "Save Tree". Then, you will find your saved file in the *~/wasekw1.0/bin/tmp/* temporary folder named same as your in-file but having a *.json* extension.

## Opening saved trees

Go to "Trees" button, select "Open Tree".
