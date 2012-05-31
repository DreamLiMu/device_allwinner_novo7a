# This script is included in squisher
# It is the final build step (after OTA package)

# Remove big videos
echo "shrinking..."
rm -f $REPACK/ota/system/media/video/*.480p.mp4
rm -f $REPACK/ota/system/lib/hw/*.goldfish.so

# System APPS+
cp -f $VENDOR_TOP/app/*.apk $REPACK/ota/system/app/
cp -f $VENDOR_TOP/app/lib/* $REPACK/ota/system/lib/

# Google services and applications
#echo "google services..."
#cp -Rf $VENDOR_TOP/gapps-ics-20120317-signed/system/* $REPACK/ota/system/
#cp -Rf $VENDOR_TOP/gapps-ics-20120317-signed/optional/face/* $REPACK/ota/system/

# Preinstalled apps (if any)
echo "preinstall apps..."
cp -f $VENDOR_TOP/preinstall/*.apk $REPACK/ota/system/preinstall/

# Delete unwanted apps
rm -f $REPACK/ota/system/app/RomManager.apk
rm -f $REPACK/ota/system/app/QuickSearchBox.apk
rm -f $REPACK/ota/system/app/Trebuchet.apk
rm -f $REPACK/ota/system/app/Gallery2.apk


# !!! TEMP: replace boot ramdisk
echo "replacing boot ramdisk"
rm -f $REPACK/ota/boot.img
cp -f $DEVICE_TOP/boot-3.0.31.img $REPACK/ota/boot.img
# !!! TEMP: fix modules loading
echo "relocating modules!!!"
rm -f $REPACK/ota/system/lib/modules/*
cp -f $DEVICE_TOP/prebuilt/lib/modules-3.0.31/* $REPACK/ota/system/lib/modules/
# !!! Firmware for various kernel modules
cp -R -f $DEVICE_TOP/prebuilt/lib/firmware/* $REPACK/ota/system/vendor/firmware/

cp -f $DEVICE_TOP/updater-script $REPACK/ota/META-INF/com/google/android/updater-script

# Touchscreen driver fix for 3.0.31+
cp -f $DEVICE_TOP/sysconfig.bin $REPACK/ota/sysconfig.bin
# U-boot Logo
cp -f $DEVICE_TOP/N7A.bmp $REPACK/ota/N7A.bmp

# Remove Mac stuff
find $REPACK/ota -name ".DS_Store" -print0 | xargs -0 rm -rf
