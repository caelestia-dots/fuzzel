#!/bin/fish

set -q XDG_CACHE_HOME && set -l cache $XDG_CACHE_HOME || set -l cache $HOME/.cache
set -l scheme_path $cache/caelestia/scheme/current.txt
set -l schemes (dirname (realpath (status filename)))/schemes
set -l default mocha

# Update scheme first
if test -f $scheme_path
    set -l config_path $schemes/(cat $scheme_path).ini
    test -f $config_path && ln -sf $config_path $schemes/current.ini || ln -sf $schemes/$default.ini $schemes/current.ini
else
    ln -sf $schemes/$default.ini $schemes/current.ini
end

# Run fuzzel
/bin/fuzzel $argv
