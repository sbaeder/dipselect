#! /bin/sh

cp /usr/sbin/pocketchip-load /usr/sbin/pocketchip-load-backup
wget -O /usr/sbin/pocketchip-load https://raw.githubusercontent.com/NextThingCo/pocketchip-load/al/inputFixes/pocketchip-load/sbin/pocketchip-load
chmod +x /usr/sbin/pocketchip-load
wget -O /usr/share/X11/xkb/symbols/pocketchip https://raw.githubusercontent.com/NextThingCo/pocketchip-configs/a524554d0c2b8715f4b7131e68055b645dcb140b/pocketchip-configs/X11/xkb/symbols/pocketchip

echo deb http://opensource.nextthing.co/chip/debian/pocketchip jessie main >> /etc/apt/sources.list
apt-get update
apt-get -y install ahoy awesome chip-sunvox pcmanfm pocketchip-batt pocketchip-configs pocketchip-list pocketchip-load pocketchip-localdoc pocketchip-onboard pocketchip-update pocket-home pocket-wm surf vala-terminal
