#!/bin/sh

echo ">>> Updating system..."
sudo freebsd-update fetch install -y
sudo pkg update && sudo pkg upgrade -y

echo ">>> Installing graphics and Xorg..."
sudo pkg install -y drm-kmod xorg xf86-input-libinput

echo ">>> Enabling Intel KMS driver..."
sudo sysrc kld_list+="i915kms"

echo ">>> Installing XFCE and LightDM..."
sudo pkg install -y xfce xfce4-goodies lightdm lightdm-gtk-greeter

echo ">>> Enabling desktop services..."
sudo sysrc dbus_enable="YES"
sudo sysrc hald_enable="YES"
sudo sysrc lightdm_enable="YES"

echo ">>> Creating .xinitrc for fallback start..."
echo "exec startxfce4" > ~/.xinitrc

echo ">>> Installing power management..."
sudo pkg install -y powerdxx
sudo sysrc powerdxx_enable=YES

echo ">>> All done!"
echo ">>> If using Wi-Fi, configure /etc/wpa_supplicant.conf manually. if you dont did it in the FreeBSD Install"
echo ">>> You can now reboot. XFCE should launch at login."

