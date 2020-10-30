#!/bin/bash

if [ $# > 0 ]; then
    for i in "$@"
    do
        if [ "$i" == "--help" ] || [ "$i" == "-h" ]; then
            echo -e "\nCommands: svmake -s topfile.v [-w waveform.vcf]\n"
            echo -e "\nAll .v and .sv files in the current folder and any subfolders will automatically be added as source files\n"
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
"$srcfiles"

if [ -n "$topmod" ]; then

IFS='.' read -ra OUT <<< "$topmod"

iverilog -Wall -g2012 -s "$topmod" -o "${OUT[0]}" "$srcfiles"
./${OUT[0]}
else
echo -e "Please specify top level file with -s flag. Use with --help for more details."
exit 1
fi

if [ -n "$waveforms" ]; then
    gtkwave $waveforms
fi