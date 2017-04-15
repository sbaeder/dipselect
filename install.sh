#! /bin/sh

echo This default installation assumes you used the CHIP 
echo flash image.  Extra PocketCHIP packages can be installed
echo with the PocketCHIP-setup.sh script provided.
echo Configurations have been provided for PocketCHIP, HDMI and
echo TZATZIFFY DIPs.  A template has also been provided for
echo other DIPs. These are kept in /usr/local/share/dipselect.
cp dipselect.service /etc/systemd/system/dipselect.service
cp dipselect.sh /usr/local/bin/dipselect.sh
cp /etc/X11/xorg.conf /etc/X11/xorg.conf.orig
cp xorg.conf.* /etc/X11
mkdir /usr/local/share/dipselect
cp *.dip /usr/local/share/dipselect
systemctl enable dipselect
/usr/local/bin/dipselect.sh
