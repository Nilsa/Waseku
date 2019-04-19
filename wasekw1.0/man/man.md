% WASEKU 1.0 

# Introduction

waseku is an interactive tool for ontogenic-like trees construction 
from hierarchical *csv* and *txt* files. It was programmed in Perl 5
using [tcl-tk](https://www.tcl.tk/man/tcl/TkCmd/ttk_treeview.htm#M27) **Tkx::tk___treeview** and hash tables as building engines for the trees 
set up. 

# Getting Started

## Installation

### Linux 64

Open a terminal pompt. Log as superuser. Dive trought wasekw folders
to wasekw1.0/installers and run

```console
~/src/Wasekw/wasekw1.0/installers$ make
```

### Windows 64

If you don't have Perl installed already, open a MS-DOS pompt and run

```console
:\> ppm install active-perl
```
then run

```
:\> perl install_windows64.pl
```

# Constrcuting the *csv files

The hierarchical structure of the in-files is stablished by tabs,
resulting in a tree-like desing contained in a grided frame (text file).
For *wasekw* work properly no tab or spaces has to exist after
the text (node) is writen down.


**Example 1**
```text_editor
root_0
	child_1
	child_2
		grand_child_2_1
	child_3
		grand_child_3_1
			grand_grand_child_3_1_1
		crand_child_3_2
        .
        .
        .
        child_N
```

once you ended, save the file as 'filename.csv' choosing *tab* as
field separator.

## Introducing the definitions

### The definitions *txt file

The file must be constructed as follows

```text_editor
Definition 0
##
Definition 2
##
Definition 3
##
.
.
.
Definition N
##
```

where ## represent two numerals.

### Add definitions

Once you have your definitions file ready, go to the 
"widgets" menu at *wasekw* main menu bar, select "Add Definitions"
and choose your definitions file.

### Viewing the definitions

To see the definition related to a node press "Alt" + click "Mouse Left".
A popup message have to appear.

## Viewing the figures

### The "figures" folder

The figure folder must contain all the figures related to the tree,
named same as the node appear on the tree.

**Example 2**
```text_editor
node0		------> node0.*png,*jpg,*gif
	node1   ------> node1.*png,*jpg,*gif
	node2   ------> node2.*png,*jpg,*gif
	.
	.
	.
	nodeN   ------> nodeN.*png,*jpg,*gif
```

### Add figures path

Go to wasekw main menu bar, press "Widgets" button, and choose "Add Figures Path",
then set the path to your figure's folder.

### View

To display the figures in the top level at the right side of wasekw main frame,
go to "Show" in the main menu bar and press "Show Figure".

