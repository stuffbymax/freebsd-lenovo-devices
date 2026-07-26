#!/bin/sh
# nvidia_mx130.sh - optional Nvidia MX130 dGPU support
# Sourced by install_xfce_*_mx130.sh scripts. Not meant to be run directly.
#
# IMPORTANT: FreeBSD has no working Optimus/PRIME render-offload or
# vga_switcheroo-style GPU switching. You get ONE of the two GPUs driving
# the display, not seamless hybrid switching like on Linux/Windows:
#
#   - Intel-only  (recommended): use i915kms, the Nvidia dGPU stays powered
#     down as far as ACPI allows, but the driver is not loaded. Best battery
#     life and stability.
#   - Nvidia-only: load the Nvidia driver instead of i915kms and drive the
#     panel from the dGPU. Usually higher power draw, and on some Optimus
#     laptops the panel is physically wired only to the iGPU (mux-less),
#     in which case this will NOT show any output at all - so try this
#     only if you've confirmed your unit works this way, or are ok
#     reverting via single-user mode / a serial console.
#
# This script installs the Nvidia driver package so it's available, but
# does NOT enable it by default - you choose which KMS driver loads.

install_nvidia_driver() {
    echo ">>> Installing Nvidia driver package for MX130..."
    sudo pkg install -y nvidia-driver

    echo ">>> Nvidia driver installed but NOT enabled by default."
    echo ">>> To try Nvidia-only mode instead of Intel iGPU:"
    echo "      sudo sysrc kld_list-=\"i915kms\""
    echo "      sudo sysrc kld_list+=\"nvidia-modeset\""
    echo "      Then set 'Driver \"nvidia\"' in /etc/X11/xorg.conf.d/ instead of intel/modesetting."
    echo ">>> If the screen stays blank after reboot, this laptop is likely mux-less"
    echo "    (panel wired to Intel only) - revert with kld_list-=\"nvidia-modeset\" from"
    echo "    single-user mode or a live USB."
}
