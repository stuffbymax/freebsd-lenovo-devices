#!/bin/sh
# Lenovo Yoga 530-14ARR - AMD Ryzen 3 2200U (Radeon Vega 3 iGPU, no dGPU)
set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/common.sh"

update_system
install_xorg_amd
install_xfce_lightdm
install_power_management_amd
final_notes
