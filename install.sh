#! /bin/sh

cp dipselect.service /etc/systemd/system/dipselect.service
cp dipselect.sh /usr/local/bin/dipselect.sh
cp xorg.conf.* /etc/X11
ln -s /etc/systemd/system/dipselect.service /etc/systemd/system/multi-user.wants
/usr/local/bin/dipselect.sh
