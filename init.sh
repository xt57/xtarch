#
#   arch install automation
#

timedatectl set-ntp true

for part in 1 2
	do
		mkfs.ext4 /dev/sda"$part"
		sleep 1
		mount /dev/sda"$part" /mnt
done

pacstrap  /mnt  base

genfstab  -U  /mnt   >>  /mnt/etc/fstab

arch-chroot  /mnt

ln -sf  /usr/share/zoneinfo/America/Chicago  /etc/localtime

hwclock --systohc

echo "en_US.UTF-8 UTF-8"		>	/etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8"			>	/etc/locale.conf

echo "vbarch"				> /etc/hostname

echo "127.0.0.1		localhost"				>	/etc/hosts	
echo "::1		localhost"				>>	/etc/hosts
echo "127.0.1.1		myhostname.localdomain	vbarch"		>>	/etc/hosts

echo "set root password"
passwd

pacman -Ss grub
grub-install		/dev/sda
grub-mkconfig	-o	/boot/grub/grub.cfg

echo "xt57 completed"
