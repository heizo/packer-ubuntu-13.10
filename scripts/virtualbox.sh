#!/bin/bash

# Without libdbus virtualbox would not start automatically after compile
apt-get -y install --no-install-recommends libdbus-1-3

# The netboot installs the VirtualBox support (old) so we have to remove it
if [ -f /etc/init.d/virtualbox-ose-guest-utils ]; then
    /etc/init.d/virtualbox-ose-guest-utils stop
fi
rmmod vboxguest
apt-get -y purge virtualbox-ose-guest-x11 virtualbox-ose-guest-dkms virtualbox-ose-guest-utils
apt-get -y install dkms

# Install the VirtualBox guest additions
VBOX_VERSION=$(cat /home/vagrant/.vbox_version)
VBOX_ISO=VBoxGuestAdditions_$VBOX_VERSION.iso
mount -o loop $VBOX_ISO /mnt
yes|sh /mnt/VBoxLinuxAdditions.run
umount /mnt

# Cleanup VirtualBox
rm $VBOX_ISO
rm /home/vagrant/.vbox_version