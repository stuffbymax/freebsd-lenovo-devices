#!/bin/sh
# common.sh - shared setup steps for Yoga 530-14IKB FreeBSD scripts
# Sourced by the model-specific install_xfce_*.sh scripts.
# Not meant to be run directly.

set -e

update_system() {
    echo ">>> Updating system..."
    sudo freebsd-update fetch install || true   # 'true' since it exits 1 if already up to date
    sudo pkg update
    sudo pkg upgrade -y
}

install_xorg_intel() {
    echo ">>> Installing graphics and Xorg (Intel iGPU)..."
    sudo pkg install -y drm-kmod xorg xf86-input-libinput

    echo ">>> Enabling Intel KMS driver (i915kms)..."
    sudo sysrc kld_list+="i915kms"
}

install_xfce_lightdm() {
    echo ">>> Installing XFCE and LightDM..."
    sudo pkg install -y xfce xfce4-goodies lightdm lightdm-gtk-greeter

    echo ">>> Enabling desktop services..."
    sudo sysrc dbus_enable="YES"
    sudo sysrc hald_enable="YES"
    sudo sysrc lightdm_enable="YES"

    echo ">>> Creating .xinitrc for fallback start..."
    echo "exec startxfce4" > ~/.xinitrc
}

install_power_management() {
    echo ">>> Installing power management..."
    sudo pkg install -y powerdxx
    sudo sysrc powerdxx_enable=YES
}

final_notes() {
    echo ">>> All done!"
    echo ">>> If using Wi-Fi, configure /etc/wpa_supplicant.conf manually if you didn't during FreeBSD install."
    echo ">>> You can now reboot. XFCE should launch at login."
}
