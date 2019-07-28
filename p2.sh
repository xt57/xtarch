#
#   p2.sh -- arch install automation
#

hwclock --systohc

locale-gen
echo "LANG=en_US.UTF-8"			>	$pre/etc/locale.conf

echo "set root password"
passwd

systemctl	start	dhcpcd
systemctl	enable	dhcpcd

pacman -Sy grub
grub-install		/dev/sda
grub-mkconfig	-o	/boot/grub/grub.cfg

#	add user buildup here

pacman	-Sy	sudo

#	i3 research below this point

#pacman -Sy	xorg-server	xorg-xinit	lightdm		tmux	i3-gaps

#systemctl	start	lightdm.service
#systemctl	enable	lightdm.service

echo "xt57 p2 completed"
