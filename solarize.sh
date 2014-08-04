#!/bin/bash
action="none"
while [ "$#" -gt 0 ]; do
	case "$1" in
    "-c") shift;action="colorize";shift;;
    "-v") shift;action="variablize";shift;;
    "-d") shift;action="darkize";shift;;
	   *) shift;;
    esac
done
variables=( '$base03' '$base02' '$base01' '$base00' '$base0' '$base1' '$base2' '$base3' '$yellow' '$orange' '$red' '$magenta' '$violet' '$blue' '$cyan' '$green' )
colors=( '#002b36' '#073642' '#586e75' '#657b83' '#839496' '#93a1a1' '#eee8d5' '#fdf6e3' '#b58900' '#cb4b16' '#dc322f' '#d33682' '#6c71c4' '#268bd2' '#2aa198' '#859900' )
function variablize () {
	for i in {0..15}; do
		sed s/${colors[$i]}/${variables[$i]}/g -i solarized-{light,dark}.css;
	done
}
function colorize () {
	for i in {0..15}; do
		sed s/${variables[$i]}/${colors[$i]}/g -i solarized-{light,dark}.css;
	done
}

if [ $action = "colorize" ]
	then
	colorize;
elif [ $action = "variablize" ]
	then
	variablize;
elif [ $action = "darkize" ]; then
	variablize;
	cp solarized-light.css solarized-dark.css;
	sed 's/[^~]\($base\)\([^~\ ]\)[\ ]/~\10\2\ /g' -i solarized-dark.css;
	sed 's/[^~]\($base\)0\([^~\ ]\)[\ ]/~\1\2\ /g' -i solarized-dark.css;
	sed 's/~/\ /g' -i solarized-dark.css
	colorize;
else
	echo $'-c - colorize (transform vars into colors);
-v - variablize (transform colors into vars);
-d - transform light into dark and colorize';exit 1;
	fi;
