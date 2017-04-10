#! /bin/sh

cp dipselect.service /etc/systemd/system/dipselect.service
cp dipselect.sh /usr/local/bin/dipselect.sh
cp xorg.conf.* /etc/X11
systemctl enable dipselect
/usr/local/bin/dipselect.sh
