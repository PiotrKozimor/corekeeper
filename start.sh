#!/bin/bash

xvfbpid=""
ckpid=""

function kill_corekeeperserver {
        if [[ ! -z "$ckpid" ]]; then
                kill $ckpid
        fi
        sleep 1
        if [[ ! -z "$xvfbpid" ]]; then
                kill $xvfbpid
        fi
}

trap kill_corekeeperserver EXIT

if ! (dpkg -l xvfb >/dev/null) ; then
    echo "Installing xvfb dependency..."
    sleep 1
    sudo apt-get update -yy && sudo apt-get install xvfb -yy
fi

set -m

rm -f /tmp/.X99-lock

Xvfb :99 -screen 0 1x1x24 -nolisten tcp &
xvfbpid=$!

rm -f GameID.txt

chmod +x ./CoreKeeperServer

DISPLAY=:99 LD_LIBRARY_PATH="$LD_LIBRARY_PATH:../Steamworks SDK Redist/linux64/" \
        ./CoreKeeperServer -nographic -batchmode -datapath /var/corekeeper -logfile /var/corekeeper/log.txt &

ckpid=$!

echo "Started server process with pid $ckpid"

while [ ! -f GameID.txt ]; do
        sleep 0.1
done

echo "Game ID: $(cat GameID.txt)"

wait $ckpid
ckpid=""