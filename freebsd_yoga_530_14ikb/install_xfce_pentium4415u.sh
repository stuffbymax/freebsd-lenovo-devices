#!/bin/sh
# Lenovo Yoga 530-14IKB - Intel Pentium 4415U (Intel HD Graphics 610, no dGPU)
set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/common.sh"

update_system
install_xorg_intel
install_xfce_lightdm
install_power_management
final_notes
