#! /bin/sh

echo "Install dipselect service. Currently requires the"
echo "GUI based OS image to read the eeproms on the DIPS."
echo
echo "Use PocketCHIPSetup.sh to add the necessary files"
echo "to use this with a PocketCHIP 'dip'"
echo
echo Configurations have been provided for PocketCHIP, HDMI and
echo TZATZIFFY DIPs.  A template has also been provided for
echo other DIPs. These are kept in /usr/local/share/dipselect.
echo
echo
if [ "$EUID" -ne 0 ]
  then echo "This needs to be run as root :-( "
  exit
fi
#
if grep -Fxq "w1_ds2431" /etc/modules
then
	echo "w1_ds2431 already in autoload..."
else
	echo "w1_ds2431" >> /etc/module
        echo "Module ws_d2431 has been added to read eeprom ..."
	echo "Please REBOOT NOW and re-run install.sh"
	exit
fi

cp dipselect.service /etc/systemd/system/dipselect.service
cp dipselect.sh /usr/local/bin/dipselect.sh
cp /etc/X11/xorg.conf /etc/X11/xorg.conf.orig
cp xorg.conf.* /etc/X11
mkdir /usr/local/share/dipselect
cp *.dip /usr/local/share/dipselect
systemctl enable dipselect
/usr/local/bin/dipselect.sh
