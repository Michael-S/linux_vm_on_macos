#!/usr/bin/env bash

### NOTE: Sometimes QEMU says "Display Disconnected"
###       or "Display Unavailable" or "Display output is
###       not active" while processes are still starting
###       up.  WAIT A FEW MINUTES BEFORE DECIDING THAT
###       THE SYSTEM IS HUNG.  It may be fine.

qemu-system-aarch64 -monitor stdio \
	-machine virt -accel hvf \
	-cpu host -smp 4 -m 8192 \
	-bios QEMU_EFI.fd -device virtio-gpu-pci \
	-display default,show-cursor=on \
	-device qemu-xhci -device usb-kbd \
	-device usb-tablet -device intel-hda \
	-device hda-duplex \
	-drive file=ubuntu.raw,format=raw,if=virtio,cache=writethrough \
        -net nic,model=virtio \
        -net user,hostfwd=tcp::5022-:22 > /dev/null 2>&1 &

