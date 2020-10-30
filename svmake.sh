#!/bin/bash

if [ $# > 0 ]; then
    for i in "$@"
    do
        if [ "$i" == "--help" ] || [ "$i" == "-h" ]; then
            echo -e "Commands: svmake -s topfile.v [-w waveform.vcf]\n"
            echo -e "All .v and .sv files in the current folder and any subfolders will automatically be added as source files\n"
            echo -e "If waveform is specified, gtkwave will also be run\n"
            exit 0
        fi
        if [ "$i" == "-s" ]; then
            shift
            if [ $# > 0 ]; then
                topmod=$1
            fi
        fi
        if [ "$i" == "-w" ]; then
            shift
            if [ $# > 0 ]; then
                waveform=$1
            fi
        fi
    done    
fi



sourcefiles=$(find * -type f -iname "*.sv" -o -type f -iname "*.v")

srcfiles=$(echo $sourcefiles | tr '\n' ' ')


if [ -n "$topmod" ]; then

IFS='.' read -ra OUT <<< "$topmod"
IFS='/' read -ra OUT2 <<< "${OUT[0]}"

iverilog -Wall -g 2012 -s ${OUT2[-1]} -o ${OUT2[-1]} $srcfiles
./${OUT[0]}
else
echo -e "Please specify top level file with -s flag. Rerun with --help for more details."
exit 1
fi

if [ -n "$waveforms" ]; then
    gtkwave $waveforms
fi