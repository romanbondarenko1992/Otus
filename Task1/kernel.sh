#!/bin/bash
mkdir ~/kernel
cd ~/kernel
yum install wget perl ncurses-devel make gcc bc openssl-devel elfutils-libelf-devel flex bison -y
wget https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.19.36.tar.xz
tar -xvf linux-4.19.36.tar.xz
cd linux-4.19.36
cp -v /boot/config-* ~/kernel/linux-4.19.36/.config
yes "" | make oldconfig &&
make bzImage &&
make modules &&
make &&
make modules_install &&
make install && 
grub2-mkconfig -o /boot/grub2/grub.cfg
grub2-set-default 0 
shutdown -r now
