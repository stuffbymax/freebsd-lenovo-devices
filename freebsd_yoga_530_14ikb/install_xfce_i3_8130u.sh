#!/bin/sh
# Lenovo Yoga 530-14IKB - Intel Core i3-8130U (Intel UHD Graphics 620, no dGPU)
set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/common.sh"

update_system
install_xorg_intel
install_xfce_lightdm
install_power_management
final_notes
