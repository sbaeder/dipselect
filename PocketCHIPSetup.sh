#! /bin/sh

echo deb http://opensource.nextthing.co/chip/debian/pocketchip jessie main >> /etc/apt/sources.list
apt-get update
apt-get -y install ahoy awesome chip-sunvox pcmanfm pocketchip-batt pocketchip-configs pocketchip-list pocketchip-load pocketchip-localdoc pocketchip-onboard pocketchip-update pocket-home pocket-wm surf vala-terminal
