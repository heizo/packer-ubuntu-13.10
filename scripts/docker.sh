#!/bin/bash
# http://docs.docker.io/en/latest/installation/ubuntulinux/#ubuntu-raring-saucy

# Optional AUFS filesystem support
apt-get -y update
apt-get -y install linux-image-extra-`uname -r`

# add docker repository
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
echo "deb http://get.docker.io/ubuntu docker main" > /etc/apt/sources.list.d/docker.list
apt-get -y update
apt-get -y install lxc-docker cgroup-lite

# Giving non-root access
groupadd docker
gpasswd -a vagrant docker

# Memory and Swap Accounting
sed -i -e 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"/g'  /etc/default/grub
update-grub
