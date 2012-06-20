#!/system/xbin/bash

BUSYBOX="/system/xbin/busybox"

if [ ! -e /data/system.notfirstrun ]; then		
	/system/bin/log -t preinstall "### Preinstall job running..."
	$BUSYBOX touch /data/system.notfirstrun	
	for f in /data/preinstall/*.apk
	do
  		/system/bin/log -t preinstall "### Processing $f file..."
		/system/bin/sh /system/bin/pm install $f
	done
	# copy android modify tool files
#	mkdir /mnt/nanda
#	mount -t vfat /dev/block/nanda /mnt/nanda
#	$BUSYBOX cp /mnt/nanda/vendor/initlogo.rle /
#	$BUSYBOX cp /mnt/nanda/vendor/system/build.prop /system/
#	$BUSYBOX cp /mnt/nanda/vendor/system/media/bootanimation.zip /system/media/
#	$BUSYBOX cp /mnt/nanda/vendor/system/usr/keylayout/*.kl /system/usr/keylayout/
#	sync
#	umount /mnt/nanda
#	rmdir /mnt/nanda
	/system/bin/log -t preinstall "### Preinstall job done"
else
    $BUSYBOX rm -rf /data/preinstall/*
fi
