#! /bin/sh

# Should add Vendor to the DIPID and switch it to numeric
# But for now...

# Generate a list of known DIPIDs
for DIP in `ls /usr/local/share/dipselect/*.dip`
do
  # Get the list of known DIPs
  DIPID=`basename $DIP .dip`
  # Unless it is our template add it to the list of DIPIDs
  KNOWNDIPS="$DIPID $KNOWNDIPS"
done

# Get the installed DIPIDs
for DIP in `ls /sys/bus/w1/devices/2*/eeprom`
do
  DIPID=`cut -c 44-76 < ${DIP}`
  INSTALLEDDIPS="$DIPID $INSTALLEDDIPS"
done

# Get the not installed DIPIDs
for DIPID in $KNOWNDIPS
do
  if `echo $INSTALLEDDIPS | grep -q $DIPID`  
  then
    # Do nothing
    : 
  else
    ABSENTDIPS="$DIPID $ABSENTDIPS"
  fi
done

echo Known: $KNOWNDIPS
echo Installed: $INSTALLEDDIPS
echo Absent: $ABSENTDIPS

# Call the Appropriate functions for the DIPs.
for DIPID in $ABSENTDIPS
do
  if [ DIPID != "template" ]
  then
    /usr/local/share/dipselect/${DIPID}.dip ABSENT
  fi
done
# template should never be installed
for DIPID in $INSTALLEDDIPS
do
  /usr/local/share/dipselect/${DIPID}.dip PRESENT
done
