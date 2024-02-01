# linux_vm_on_macos
Setup steps to get an ARM64 Ubuntu VM running on an Apple Silicon, Apple OS host

I set this up because it took me longer than I would have liked to figure
out from various websites.

_As far as I know_ all of the compiled information is public domain and does
not violate any licenses.

### Before You Start

You need:

1. A MacOS device running an M1 or newer processor.
2. QEMU installed on the MacOS device. (I recommend using brew,
   so installation would be `brew install qemu`.)
3. The file `QEMU_EFI.fd` for aarch64/ARM64.  I had a Linux server
   available so I did `sudo apt install qemu-efi-aarch64` and
   then copied `/usr/share/qemu-efi-aarch64/QEMU_EFI.fd` to
   the directory with these files.
4. A Linux ARM64/aarch64 installer ISO.

### To Use

Modify the `install_vm.sh` script to change the disk image
name and size, if necessary. Also change the referenced
Linux installation .iso file.

Then do `./install_vm.sh` to run the installation.

*NOTE*: at times, QEMU will display "Display is not available
on screen".  That could mean everything is busted, but
it could also mean you just need to wait.  Give it one to
two minutes to see if anything happens before closing out
QEMU and trying again.

After you've run through the installer to set up your VM,
you can shut it down.  Then `./run_vm.sh` will run it.

Note that I used output redirection on the QEMU commands
so that your terminal doesn't get taken over by QEMU.
That's the `>/dev/null 2>&1 &` at the end.  The
`>/dev/null` redirects the standard output (stdout) to
get rid of it.  The `2>&1` redirects the standard error
output (stderr) to stdout, so it's eliminated too. And
the final `&` runs the process in the background.

If your commands are erroring out and you need to see
the output, remove the whole `>/dev/null 2>&1 &` and
try again.

### SSH 

I have the command set to map port 5022 on the host
to 22 on the VM, so you can do
`ssh -p 5022 localhost` to ssh to your VM (if you
set up an SSH server on your VM).


