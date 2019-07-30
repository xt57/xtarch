#
#   p2.sh -- arch install automation
#

hwclock --systohc

locale-gen
echo "LANG=en_US.UTF-8"			>	$pre/etc/locale.conf

echo "set root password"
passwd

# add users and their attributes here
useradd	-m	-g wheel	ag20253
echo "set user password"
passwd					ag20253

systemctl	start	dhcpcd
systemctl	enable	dhcpcd

pacman -Sy --noconfirm	grub

grub-install		/dev/sda
grub-mkconfig	-o	/boot/grub/grub.cfg

echo "xt57 p2 completed"
