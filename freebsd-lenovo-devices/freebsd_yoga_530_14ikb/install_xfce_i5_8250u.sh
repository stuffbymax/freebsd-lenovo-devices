#!/bin/sh
# Lenovo Yoga 530-14IKB - Intel Core i5-8250U, Intel-only SKU (no Nvidia MX130)
# If your unit has the MX130 dGPU, use install_xfce_i5_8250u_mx130.sh instead.
set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/common.sh"

update_system
install_xorg_intel
install_xfce_lightdm
install_power_management
final_notes
