######################### waseku 1.0 - Manual #########################

#0.0 Introduction

waseku is an interactive tool for ontogenic trees construction 
from hierarchical *csv and *txt files. It was programmed in Perl 5
using Tkx::treeview and hash tables as building engines for the trees 
set up. 

#1.0 Getting Started

##1.1 Installation

###1.1.1 Linux 64

Open a terminal pompt. Log as superuser. Dive trought wasekw folders
to wasekw1.0/installers and run

```console
~/src/Wasekw/wasekw1.0/installers$ make
```

###1.1.2 Windows 64

If you don't have Perl installed already, open a MS-DOS pompt and run

:\> ppm install active-perl

then run

:\> perl install_windows64.pl

#2.0 Constrcuting the *csv files

The hierarchical structure of the in-files is stablished by tabs,
resulting in a tree-like desing contained in a grided frame (text file).
For wasekw work properly no tab or spaces has to exist after
the text (node) is writen down.


%Example 1
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
%end Example 1

once you ended, save the file as 'filename.csv'.

##2.1 Introducing the definitions

###2.1.1 The definitions *txt file

The file must be constructed as follows

Definition 0
'##'
Definition 2
'##'
Definition 3
'##'
...
Definition N
'##'

where '##' represent two numerals.

###2.1.2 Add definitions

Once you have your definitions file ready, go to the 
"widgets" menu at waswkw main menu bar, select "Add Definitions"
and choose your definitions file.

###2.1.3 Viewing the definitions

To see the definition related to a node press "Alt" + click "Mouse Left".
A popup message have to appear.

##2.2 Viewing the figures

###2.2.1 The "figures" folder

The figure folder must contain all the figures related to the tree,
named same as the node appear on the tree.

%Example 2
```
node0		------> node0.*png,*jpg,*gif
	node1   ------> node1.*png,*jpg,*gif
	node2   ------> node2.*png,*jpg,*gif
	.
	.
	.
	nodeN   ------> nodeN.*png,*jpg,*gif
```
%end Example 2

###2.2.2 Add figures path

Go to wasekw main menu bar, press "Widgets" button, and choose "Add Figures Path",
then set the path to your figure's folder.

###2.2.3 View

To display the figures in the top level at the right side of wasekw main frame,
go to "Show" in the main menu bar and press "Show Figure".

