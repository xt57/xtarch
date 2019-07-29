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

#	pacman	-S	sudo

#	i3 research below this point

log=./log
> $log

#for pkg in	xorg-server	xorg-xinit	i3-gaps		lightdm
for pkg in	xorg-server	xorg-xinit	i3-gaps		dmenu
	do
	echo "installing $pkg"			>>	$log
	pacman -S --noconfirm	$pkg	>>	$log 2>&1
done

#systemctl	start	lightdm.service
#systemctl	enable	lightdm.service

echo "be sure to setup /home/ag20253/.xinit"

echo "xt57 p2 completed"
