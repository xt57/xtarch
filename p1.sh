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

#	arch-chroot  /mnt

pre=/mnt

ln -sf  $pre/usr/share/zoneinfo/America/Chicago  $pre/etc/localtime

#	hwclock --systohc

echo "en_US.UTF-8 UTF-8"		>	$pre/etc/locale.gen
#	locale-gen
echo "LANG=en_US.UTF-8"			>	$pre/etc/locale.conf

echo "vbarch"					> $pre/etc/hostname

echo "127.0.0.1		localhost"				>	$pre/etc/hosts	
echo "::1		localhost"				>>	$pre/etc/hosts
echo "127.0.1.1		myhostname.localdomain	vbarch"		>>	$pre/etc/hosts

#	echo "set root password"
#	passwd

#	pacman -Sy grub
#	grub-install		/dev/sda
#	grub-mkconfig	-o	/boot/grub/grub.cfg

#	echo "xt57 p1 completed"
