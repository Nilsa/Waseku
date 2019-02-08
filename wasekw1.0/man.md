######################### waseku-core Manual #########################

#0.0 Introduction

wasekw-core is an interactive tool for ontogenic trees construction 
from hierarchical *csv and *txt files. It was programmed in Perl 5
using Tkx::treeview and hash tables as building engines for the trees 
set up. 

#1.0 Getting Started

#1.1 Installation

#1.1.1 Linux 64

Linux/Unix users can compile the wasekw.pl in the wasekw-main folder.

pp -o wasekw wasekw.pl

* if not pp installed, run:
* sudo apt-get install libpar-packer-perl

#1.1.2 Windows 64

Windows users can run directly the wasekw executable frog-icon.

#2.0 Constrcuting the *csv files

The hierarchical structure of the in-files is stablished by tabs.
Resulting in a tree-like desing in a grid frame (text file).
For wasekw work properly no tab or spaces has to exist after
the text (node) is writen down.


%Example 1

Root_0
	Child_1
	Child_2
		Grand_Child_2-1
	Child_3
		Grand_Child_3-1
			G_Grand_Child_3-1-1
		Grand_Child_3-2
        .
        .
        .
        Child_N

%end Example 1

once you ended, save the file as "your_file_name.csv".

#2.1 Introducing the definitions

#2.1.1 The definitions *txt file

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

#2.1.2 Add definitions

Once you have your definitions file ready, go to the 
"widgets" menu at waswkw main menu bar, select "Add Definitions"
and choose your file.

#2.1.3 Viewing the definitions

To see the definition related to a node press "Alt" + click "Mouse Left",
and a popup message have to appear.

#2.2 Viewing the figures

#2.2.1 The "figures" folder

The figure folder must contain all the figures related to the tree,
named same as the node appear on the tree.

%Example 2

node0		------> node0.*png,*jpg,*gif
	node1   ------> node1.*png,*jpg,*gif
	node2   ------> node2.*png,*jpg,*gif
.
.
.
	nodeN   ------> nodeN.*png,*jpg,*gif

%end Example 2

#2.2.2 Add figures path

Go to wasekw main menu bar, press "Widgets" button, and choose "Add Figures Path",
then set the path to your figure's folder.

#2.2.3 View

To display the figures in the top level at the right side of wasekw main frame,
go to "Show" in the main menu bar and press "Show Figure".
