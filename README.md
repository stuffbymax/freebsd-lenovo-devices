# FreeBSD on Lenovo Yoga 530-14IKB

Install scripts to get a working XFCE desktop on FreeBSD, for the different
CPU/GPU configurations the Yoga 530-14IKB shipped in.

## Which script do I run?

| CPU | dGPU | Script |
|---|---|---|
| Pentium 4415U | none (Intel HD 610) | `install_xfce_pentium4415u.sh` |
| Core i3-8130U | none (Intel UHD 620) | `install_xfce_i3_8130u.sh` |
| Core i5-8250U | none (Intel UHD 620) | `install_xfce_i5_8250u.sh` |
| Core i5-8250U | Nvidia MX130 | `install_xfce_i5_8250u_mx130.sh` |
| Core i7-8550U | Nvidia MX130 | `install_xfce_i7_8550u_mx130.sh` |

Not sure if your unit has the MX130? Check before running anything:

```sh
pciconf -lv | grep -i vga
```

If you only see an Intel VGA device, use one of the no-dGPU scripts even if
your CPU is i5/i7 — the MX130 was optional on those SKUs.

## Usage

```sh
git clone https://github.com/stuffbymax/freebsd_yoga_530_14ikb.git
cd freebsd_yoga_530_14ikb
chmod +x *.sh
./install_xfce_<your_model>.sh
```

`common.sh` (and `nvidia_mx130.sh` for the dGPU variants) must stay in the
same folder — the model scripts source them rather than duplicating the
logic.

## What the scripts do

1. Update the base system and packages (`freebsd-update`, `pkg upgrade`)
2. Install `drm-kmod` + Xorg and enable the Intel `i915kms` driver
3. (MX130 variants only) install the `nvidia-driver` package
4. Install XFCE + LightDM and enable `dbus`, `hald`, `lightdm`
5. Write a fallback `~/.xinitrc` (`exec startxfce4`)
6. Install `powerdxx` for CPU frequency scaling / power management

After it finishes, reboot and LightDM should bring you into XFCE.

## About the Nvidia MX130 scripts

FreeBSD has **no working Optimus / hybrid-graphics switching** — there's no
equivalent of `vga_switcheroo` or NVIDIA PRIME render offload. You get one
GPU driving the display, not seamless switching between them.

The MX130 scripts install the Nvidia driver but leave `i915kms` (Intel) as
the active KMS driver by default. That's the recommended mode: best battery
life and stability, dGPU just stays idle.

If you want to try Nvidia-only mode instead:

```sh
sudo sysrc kld_list-="i915kms"
sudo sysrc kld_list+="nvidia-modeset"
```

Then set `Driver "nvidia"` in your Xorg config instead of `intel`/`modesetting`.

**Warning:** some Yoga 530 units are mux-less, meaning the display panel is
physically wired only to the Intel iGPU. On those units, Nvidia-only mode
will boot to a blank screen. If that happens, revert from single-user mode
or a live USB:

```sh
sudo sysrc kld_list-="nvidia-modeset"
sudo sysrc kld_list+="i915kms"
```

## Wi-Fi

If you didn't configure Wi-Fi during the FreeBSD install, set it up manually
in `/etc/wpa_supplicant.conf` before or after running these scripts.

## Notes

- Scripts are POSIX `sh`, tested with `sh -n` for syntax only — review
  before running on your own machine, especially the Nvidia switching steps.
- PRs welcome if you've got a Yoga 530-14IKB variant not covered here.
