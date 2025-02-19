#!/bin/fish

set -q XDG_CACHE_HOME && set -l cache $XDG_CACHE_HOME || set -l cache $HOME/.cache
set -l scheme_path $cache/caelestia/scheme/current.txt
set -l schemes (dirname (status filename))/../schemes

cp $schemes/template.ini $schemes/current.ini
cat $scheme_path | while read line
    set -l colour (string split ' ' $line)
    sed -i "s/\$$colour[1]/$colour[2]/g" $schemes/current.ini
end

