#!/bin/fish

set -q XDG_CACHE_HOME && set -l cache $XDG_CACHE_HOME || set -l cache $HOME/.cache
set -l scheme_path $cache/caelestia/scheme/current.txt
set -l schemes (dirname (status filename))/../schemes

set -l current $schemes/(cat "$scheme_path").ini
test -f $current && ln -sf $current $schemes/current.ini || ln -sf $schemes/mocha.ini $schemes/current.ini
