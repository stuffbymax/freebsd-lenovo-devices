#!/bin/sh
# Lenovo Yoga 530-14IKB - Intel Core i5-8250U + Nvidia GeForce MX130 (hybrid graphics SKU)
# See nvidia_mx130.sh for important notes on FreeBSD's lack of Optimus support.
set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/common.sh"
. "$SCRIPT_DIR/nvidia_mx130.sh"

update_system
install_xorg_intel
install_nvidia_driver
install_xfce_lightdm
install_power_management
final_notes
