#!/bin/bash

autohost="192.168.122.198"
cpu="2"
cent="centos7.0"

read -p "Please enter a hostname: " name
image=$(echo $name)
# Enter Disk Size. Dont select disk size larger than 60GB
while :; do
  read -p "Please enter a disk size from 10 - 60GB: " dsize
  [[ $dsize =~ ^[0-9]+$ ]] || { echo "Enter a valid number"; continue; }
  if ((dsize >= 10 && dsize <= 60)); then
    echo "$dsize is a valid Disk Size"
    break
  else
    echo "Disk size must be within range 5GB - 100GB"
  fi
done

#Confirm disk space is in range
while :; do
  read -p "RAM selection in GB(s):
  enter a number from 1 - 10 (GB):" ram_select
  [[ $ram_select =~ ^[0-9]+$ ]] || { echo "Enter a valid number"; continue; }
  if ((ram_select >= 1 && ram_select <= 10)); then
    echo "$dsize is a valid RAM selection"
    break
  else
    echo "RAM size must be between 1GB - 10GB"
  fi
done

case $ram_select in
     1)
          echo "1 GB"
          mem="1024"
          ;;
     2)
          echo "2 GB"
          mem="2048"
          ;;
     3)
          echo "3 GB"
          mem="3072"
          ;;
     4)
          echo "4 GB"
          mem="4096"
          ;;
     5)
          echo "5 GB"
          mem="5120"
          ;;
     6)
          echo "6 GB"
          mem="6144"
          ;;
     7)
          echo "7 GB"
          mem="6144"
          ;;
     8)
          echo "8 GB"
          mem="6144"
          ;;
     9)
          echo "9 GB"
          mem="6144"
          ;;
     10)
          echo "10 GB"
          mem="6144"
          ;;
esac

virt-install --name $name \
    --memory $mem \
    --vcpus 2 \
    --disk /var/lib/libvirt/images/$image.qcow2,size=$dsize,bus=virtio,device=disk \
    --location /var/distros/CentOS-7-x86_64-Minimal-2003.iso \
    --network bridge=virbr0 \
    --noautoconsole --vnc --wait \
    --initrd-inject test.cfg \
    --extra-args="ks=file:/test.cfg console=tty0"
