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

for pkg in	xorg-server	xorg-xinit	i3-gaps		dmenu
	do
	echo									|	tee -a $log
	echo "installing $pkg"					|	tee -a $log
	echo									|	tee -a $log
	pacman -S --noconfirm	$pkg	2>&1 	|	tee -a $log
done

echo "be sure to setup /home/ag20253/.xinit"

echo "xt57 p2 completed"
