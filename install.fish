#!/bin/fish

set -q XDG_CONFIG_HOME && set -l conf $XDG_CONFIG_HOME || set -l conf $HOME/.config
set -l config $conf/fuzzel

# Prompt if already exists
if test -d $config
    read -l -p "echo -n '$config already exists. Overwrite? [y/N] '" confirm
    if test "$confirm" = 'y' -o "$confirm" = 'Y'
        echo 'Continuing.'
        rm -rf $config
    else
        echo 'Exiting.'
        exit
    end
end

git clone 'https://github.com/caelestia-dots/fuzzel.git' $config

# Install systemd service
if test -d $conf/systemd/user
    echo "[Service]
Type=oneshot
ExecStart=$config/monitor/update.fish" > $conf/systemd/user/fuzzel-monitor-scheme.service
    cp $config/monitor/fuzzel-monitor-scheme.path $conf/systemd/user/fuzzel-monitor-scheme.path

    systemctl --user daemon-reload
    systemctl --user enable --now fuzzel-monitor-scheme.path
end

echo 'Done.'
