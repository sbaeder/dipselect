#! /bin/sh
#
#  Configure a "normal" GUI image to support a pocketchip.
#
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi
#
# We might be able to skip this eventually...Need to double check...
cp /usr/sbin/pocketchip-load /usr/sbin/pocketchip-load-backup
wget -O /usr/sbin/pocketchip-load https://raw.githubusercontent.com/NextThingCo/pocketchip-load/al/inputFixes/pocketchip-load/sbin/pocketchip-load
chmod +x /usr/sbin/pocketchip-load
wget -O /usr/share/X11/xkb/symbols/pocketchip https://raw.githubusercontent.com/NextThingCo/pocketchip-configs/a524554d0c2b8715f4b7131e68055b645dcb140b/pocketchip-configs/X11/xkb/symbols/pocketchip

# Make sure we add the current package repository, and do an update before the installation of the PChip packages
echo deb http://opensource.nextthing.co/chip/debian/pocketchip jessie main >> /etc/apt/sources.list

apt-get update
# These are the apps to display startup screens and the local docs and "on-boarding" screens, the screen manager and some apps
apt-get -y install ahoy pocketchip-localdoc pocketchip-onboard awesome chip-sunvox pcmanfm surf vala-terminal

# battery monitoring, keyboard and screen configuration files, load the configs, the lightdm and manage display brightness
apt-get -y install pocketchip-batt pocketchip-configs pocketchip-load  

# Not sure what these have or do yet.
apt-get -y install pocketchip-update pocket-wm pocketchip-list 

# from marshmallow's directions...to use HIS Pocket-home
apt-get -y install apt-transport-https
echo "deb https://o-marshmallow.github.io/PocketCHIP-pocket-home/archive/ jessie main" | sudo tee /etc/apt/sources.list.d/marshmallow-pocket-chip-home.list
apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 584F7F9F
apt-get update
apt-get -y install pocket-home


############################################
# Other things from the NTC github scripts #
# used during building the images...       #
############################################

# battery-warning poweroff fix (change "allow any" to yes)
apt-get install -y --allow-unauthenticated xmlstarlet
xmlstarlet ed -u\
	"/*/action[@id='org.freedesktop.login1.power-off']/defaults/allow_any" -v "yes" \
    /usr/share/polkit-1/actions/org.freedesktop.login1.policy > \
    /usr/share/polkit-1/actions/org.freedesktop.login1.policy.new
mv /usr/share/polkit-1/actions/org.freedesktop.login1.policy.new \
    /usr/share/polkit-1/actions/org.freedesktop.login1.policy

# hacks for pocketchip gtk file dialog size
	mkdir -p /home/chip/.config
	cp -R /etc/skel/.config/gtk-2.0 /home/chip/.config/
	chown -R root:root /home/chip/.config/gtk-2.0
	chmod 655 /home/chip/.config/gtk-2.0
	chmod 644 /home/chip/.config/gtk-2.0/*
	
 # Configure the journald to use smaller amounts and also Volatile storage.
	sed -i -e 's/#Storage=.*/Storage=volatile/' /etc/systemd/journald.conf
	sed -i -e 's/#SystemMaxUse=.*/SystemMaxUse=10M/' /etc/systemd/journald.conf
	sed -i -e 's/#SystemKeepFree=.*/SystemKeepFree=5M/' /etc/systemd/journald.conf
	sed -i -e 's/#RuntimeMaxUse=.*/RuntimeMaxUse=10M/' /etc/systemd/journald.conf
	sed -i -e 's/#RuntimeKeepFree=.*/RuntimeKeepFree=5M/' /etc/systemd/journald.conf
