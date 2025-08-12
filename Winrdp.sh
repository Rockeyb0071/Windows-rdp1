#!/bin/bash
echo "🚀 Setting up Windows Server 2019 RDP..."

sudo apt update -y
sudo apt install wget curl -y

# Install QEMU for virtual machine
sudo apt install qemu qemu-kvm libvirt-daemon libvirt-clients bridge-utils virt-manager -y

# Download Windows Server 2019 image
wget -O win2019.iso https://archive.org/download/windows-server-2019-evaluation/Windows%20Server%202019%20Evaluation.iso

# Create 20GB disk
qemu-img create -f qcow2 win2019.qcow2 20G

# Start VM
nohup qemu-system-x86_64 \
  -m 4096 \
  -hda win2019.qcow2 \
  -cdrom win2019.iso \
  -boot d \
  -enable-kvm \
  -cpu host \
  -smp cores=2 \
  -vnc :1 \
  -net nic \
  -net user,hostfwd=tcp::3389-:3389 \
  &

echo "✅ Windows Server 2019 VM is starting..."
echo "🔑 Use IP: 127.0.0.1 with RDP (port 3389)"
echo "🕒 Wait 2–3 minutes before connecting."
