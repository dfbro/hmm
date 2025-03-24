#!/bin/bash
#/opt/qemu.sh
# Function to send ACPI shutdown to QEMU
shutdown_qemu() {
    echo "Sending ACPI shutdown to QEMU..."
    echo 'system_powerdown' | socat - UNIX-CONNECT:/tmp/qemu-monitor.sock
    #reattach
    socat -,raw,echo=0,escape=0x1d UNIX-CONNECT:/tmp/qemu-serial.sock
}

# Trap SIGINT (Ctrl+C) and SIGTERM signals
trap shutdown_qemu SIGINT SIGTERM EXIT


qemu-system-x86_64 -drive file=/opt/ubuntu-22.qcow2,format=qcow2 -drive file=/opt/user-data.img,format=raw -nographic -virtfs local,path=/opt/shared,mount_tag=shared,security_model=none -m 7G -net nic,model=virtio -monitor unix:/tmp/qemu-monitor.sock,server,nowait -enable-kvm -cpu host -smp $(nproc) -net user,hostfwd=tcp::2222-:22 -serial unix:/tmp/qemu-serial.sock,server,nowait >> /var/log/qemu.log 2>&1 &

# Wait for QEMU to create the serial socket
while [ ! -e /tmp/qemu-serial.sock ]; do
    sleep 1
done

# Attach to the serial console inside the same "qemu" screen session with Ctrl+Esc as exit key
socat -,raw,echo=0,escape=0x1d UNIX-CONNECT:/tmp/qemu-serial.sock

