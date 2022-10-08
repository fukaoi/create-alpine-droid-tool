#!/system/bin/sh
set -e

# PARAMETERS ---
DEST='/data/alpineLinux'
MIRR='https://dl-cdn.alpinelinux.org/alpine'
DNS1='1.1.1.1'
DNS2='1.0.0.1'
# --------------

# Prepare (start)
ARCH=`uname -m`
mkdir -p $DEST
cd $DEST
echo "> prepare"
# Prepare (end)
# Download rootfs (start) echo "< download rootfs"
FILE=`wget -qO- "$MIRR/latest-stable/releases/$ARCH/latest-releases.yaml" | grep -o -m 1 'alpine-minirootfs-.*.tar.gz'`

wget "$MIRR/latest-stable/releases/$ARCH/$FILE" -O rootfs.tar.gz
echo "> download rootfs"
# Download rootfs (end)



# Extract rootfs (start)
echo "< extract rootfs"
tar -xvzf rootfs.tar.gz
echo "> extract rootfs"
# Extract rootfs (end)



# Configure (start)
echo "> configure"
mkdir -p mnt/sdcard

echo "nameserver $DNS1
nameserver $DNS2" > etc/resolv.conf

echo "#!/bin/sh -e
mount -t proc none $DEST/proc
mount --rbind /sys $DEST/sys
mount --rbind /dev $DEST/dev
mount --rbind /sdcard $DEST/mnt/sdcard" > up.sh

echo "#!/bin/sh 
umount $DEST/proc
umount -l $DEST/sys
umount -l $DEST/dev
umount -l $DEST/mnt/sdcard" > down.sh

echo "#!bin/sh 
chroot $DEST /bin/sh --login" > chroot.sh

chmod +x {up,down,chroot}.sh
echo "< configure"
# Configure (end)
