#!/usr/bin/env bash

### NOTE: Sometimes QEMU says "Display Disconnected"
###       or "Display Unavailable" or "Display output is
###       not active" while processes are still starting
###       up.  WAIT A FEW MINUTES BEFORE DECIDING THAT
###       THE SYSTEM IS HUNG.  It may be fine.

# The QEMU_EFI.fd file comes from the Linux
# package https://packages.debian.org/sid/qemu-efi-aarch64
# the ARM installer for Ubuntu was downloaded from the
# official website.

# The only difference between this file and the other
# is the creation of the raw disk image
# and the addition of the -cdrom entry at start

# This creates a raw disk image of 30GB. Naturally,
# you need at least 30GB of free space for this
# to work.
qemu-img create -f raw ubuntu.raw 30G

qemu-system-aarch64 -monitor stdio \
	-machine virt -accel hvf \
	-cpu host -smp 4 -m 8192 \
	-bios QEMU_EFI.fd -device virtio-gpu-pci \
	-display default,show-cursor=on \
	-device qemu-xhci -device usb-kbd \
	-device usb-tablet -device intel-hda \
	-device hda-duplex \
	-drive file=ubuntu.raw,format=raw,if=virtio,cache=writethrough \
	-cdrom ubuntu-22.04.3-live-server-arm64.iso \
        -net nic,model=virtio \
        -net user,hostfwd=tcp::5022-:22 > /dev/null 2>&1 &
