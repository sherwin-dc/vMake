# vMake
## Introduction

vMake wraps the Verilog Compile - Simulate - Waveform View workflow into a single command. vMake runs the Icarus Verilog compiler, the simulation and gtkwave 

vMake uses a makefile called vMakefile to specify the top module and source files for the compiler and the waveform files for gtkwave


## Installation
Clone or download the repo and the setup.sh with sudo permissions (as it will copy the needed file to /usr/local/bin to allow program to be run from any directory)

## Prerequisites
vMake requires Icarus Verilog and gtkwave to be installed 

## Usage
Note: the vMakefile for the project must be present in the directory

Type "vMake" into the terminal 
```    vMake```

### Options
Specify Makefile:
``` vmake -f {Makefile}```
- the default Makefile name is "vMakefile"

Show help:
``` vmake --help```

## vMakefile
the vMakefile contains the details of the top module and source files for the verilog compiler and any waveform files to be viewed in gtkwave

(a sample vMakefile is included in the repo)

### Syntax
TOPMOD=[name of top module]
 - if called more than once, the latest call will take precedence

FILE=[name of Verilog source file to add to compiler]
 - only 1 file can be added at a time
 - can be used multiple times to add different files

WAVEFORM=[name of waveform file to be viewed in gtkwave]
 - if no waveform files are specified, gtkwave will not be run

 "#" Comments
 - does not support same line comments (yet)

 # Alternate script svmake

 ### Description
 Specify only the top file and optionally, the waveform file
 svmake will automatically add all .v and .sv files in the current folder and all subfolders as sourcefiles

 If a waveform file is specified, then gtkwave will automatically be launched

 This can be run from a different folder provided all source files exist within the directory or subfolders
 In this case specify top file as the full path to file. ie `-s folder/subfolder/file.v`. The executible will always be created in the current directory

 ### Syntax
 ``` svmake -s top_file.v [ -w waveform_file.vcf ]```

 ### Example
 ``` svmake -s folder1/top_level.sv -w waveform.vcf```

 ### Misc
 Using folders and files with spaces has not been tested but is expected not to work