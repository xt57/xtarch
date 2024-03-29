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

pacman -S --noconfirm	reflector

mirrors=/etc/pacman.d/mirrorlist
cp -p		$mirrors	$mirrors.orig
reflector 	--country 	"United States" 	--age 36 --protocol https --sort rate --save $mirrors
#	egrep 	"gigenet"		$mirror.orig >	$mirror


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

echo "127.0.0.1		localhost"						>	$pre/etc/hosts	
echo "::1			localhost"						>>	$pre/etc/hosts
echo "127.0.1.1		myhostname.localdomain	vbarch"	>>	$pre/etc/hosts

cp -p  p2.sh	/mnt
cp -p  p3.sh	/mnt

arch-chroot  	/mnt	bash -x ./p2.sh

echo "xt57 completed - press return to shutdown"
read x
shutdown -h now

