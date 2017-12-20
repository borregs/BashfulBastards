:'
 GRAPICS ENABLED CHROOT SCRIPTb
 Ubuntuish
'
# Mount ur device prior to running this
# this is usually done by a graphical application
# but mount methods vary for diferent media and fmts

GROOTP="{mountpoint}"
read -p "Insert Path of device to chroot in like a G >>" GROOTP

sudo mount --bind /dev $GROOTP/dev
sudo mount --bind /tmp $GROOTP/tmp
sudo mount --bind /sys $GROOTP/sys
sudo mount --bind /proc $GROOTP/proc
sudo mount --bind /etc $GROOTP/etc

 
sudo cp /etc/resolv.conf $GROOTP/etc/resolv.conf 

sudo xhost +
sudo chroot $GROOTP
