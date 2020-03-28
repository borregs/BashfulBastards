#!/bin/bash
echo ""

echo lsblk
echo ""


PART=read -p "indique la particion booteable arch q nose deja"
PART="/dev/null"
DUMMY="/media/usb"
echo $PART

sudo mkdir -p $DUMMY

mount $PART $DUMMY
vim $DUMMY/etc/mkinitcpio.conf

for a in sys dev proc; do mount --bind /$a $DUMMY/$a; done
chroot $DUMMY

        mkinitcpio -p linux
        sudo pacman -Sy grub os-prober --assume-no
        cd boot/grub/
        sudo grub-mkconfig > grub.cfg
        grub-install $PART
        exit
sync
#reboot
