#! /bin/sh

# Get the DIPIDs
for DIP in `ls /sys/bus/w1/devices/2*/eeprom`
do
  DIPID=`cut -c 44-76 < ${DIP}`

  case ${DIPID} in

    "PocketCHIP")
      # Move the xorg.conf into place
      rm -f /etc/X11/xorg.conf 
      ln -s /etc/X11/xorg.conf.PocketCHIP /etc/X11/xorg.conf
      ;;

    "TZATZIFFY")
      # Move the xorg.conf into place
      rm -f /etc/X11/xorg.conf 
      ln -s /etc/X11/xorg.conf.Tzatziffy /etc/X11/xorg.conf
      ;;

    *) # Unknown DIP
      ;;

  esac
done 

