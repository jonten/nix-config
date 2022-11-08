#!/usr/bin/env bash

# Add the disk you want to partition by using 'ls /dev/disk-by-id'
DISK="$1"
# Set the name for the ZFS root pool
ROOT_POOL_NAME="${2:-zroot}"
# Set how large you want the root pool to be. Use empty to use rest of the disk
INST_PARTSIZE_RPOOL="${3:-}"
# Set how large swap partition you want to have
INST_PARTSIZE_SWAP="${4:-8}"
# Enable disk encryption. Default no
DISK_ENCRYPTION="${5:-no}"

if [[ $(id -u) -ne 0 ]]; then
    echo "You need to run this script as root or with sudo"
    exit 1
fi

usage() {
cat <<EOF
You need to run this script as root or with sudo!
You also need to specify at least one argument, the disk to partition, to this script!
Example: sudo ./zfs-setup.sh "<disk-by-id-1|[disk-by-id-2]>" "[root-pool-name]" [root-partition-size] [swap-partition-size] disk encryption "[yes|no]"
EOF
exit 1
}

# Check if DISK variable is empty or contain one or more disks
#case in "$(echo $1 | wc -w)"
case "$(echo ${DISK} | wc -w)" in
    2) MIRROR='mirror \';;
    1) echo "Only one disk is specified, not using mirror option";;
    0) usage;;
    *) echo "Something went wrong! Unspecified number of arguments!"; exit 1;;
esac

echo Do you want to start setting up ZFS?
read foo

# Partition disks
for i in ${DISK}; do

sgdisk --zap-all $i

sgdisk -n1:1M:+1G -t1:EF00 $i

sgdisk -n2:0:+4G -t2:BE00 $i

test -z $INST_PARTSIZE_SWAP || sgdisk -n4:0:+${INST_PARTSIZE_SWAP}G -t4:8200 $i

if test -z $INST_PARTSIZE_RPOOL; then
    sgdisk -n3:0:0   -t3:BF00 $i
else
    sgdisk -n3:0:+${INST_PARTSIZE_RPOOL}G -t3:BF00 $i
fi

sgdisk -a1 -n5:24K:+1000K -t5:EF02 $i
done

echo Do you want to continue? Press Ctrl+C to abort!
read foo

    

# Create ZFS boot pool
zpool create \
    -o compatibility=grub2 \
    -o ashift=12 \
    -o autotrim=on \
    -O acltype=posixacl \
    -O canmount=off \
    -O compression=lz4 \
    -O devices=off \
    -O normalization=formD \
    -O relatime=on \
    -O xattr=sa \
    -O mountpoint=/boot \
    -R /mnt \
    bpool \
    ${MIRROR}
    $(for i in ${DISK}; do
       printf "$i-part2 ";
      done)

echo Do you want to continue? Press Ctrl+C to abort!
read foo


# Create ZFS root pool
zpool create \
    -o ashift=12 \
    -o autotrim=on \
    -R /mnt \
    -O acltype=posixacl \
    -O canmount=off \
    -O compression=zstd \
    -O dnodesize=auto \
    -O normalization=formD \
    -O relatime=on \
    -O xattr=sa \
    -O mountpoint=/ \
    ${ROOT_POOL_NAME} \
    ${MIRROR}
   $(for i in ${DISK}; do
      printf "$i-part3 ";
     done)

echo Do you want to continue? Press Ctrl+C to abort!
read foo


# Enable ZFS full disk encryption
if [[ ${DISK_ENCRYPTION} == "yes" ]]; then
    # Create ZFS filesystems
    # Encrypted setup
    zfs create \
     -o canmount=off \
     -o mountpoint=none \
     -o encryption=on \
     -o keylocation=prompt \
     -o keyformat=passphrase \
     ${ROOT_POOL_NAME}/nixos
else
    # Unencrypted setup
    zfs create \
     -o canmount=off \
     -o mountpoint=none \
     ${ROOT_POOL_NAME}/nixos
fi

echo Do you want to continue? Press Ctrl+C to abort!
read foo


# Create ZFS datasets
zfs create -o canmount=on -o mountpoint=/     ${ROOT_POOL_NAME}/nixos/root
zfs create -o canmount=on -o mountpoint=/home ${ROOT_POOL_NAME}/nixos/home
zfs create -o canmount=off -o mountpoint=/var  ${ROOT_POOL_NAME}/nixos/var
zfs create -o canmount=on  ${ROOT_POOL_NAME}/nixos/var/lib
zfs create -o canmount=on  ${ROOT_POOL_NAME}/nixos/var/log

zfs create -o canmount=off -o mountpoint=none bpool/nixos
zfs create -o canmount=on -o mountpoint=/boot bpool/nixos/root

echo Do you want to continue? Press Ctrl+C to abort!
read foo


# Format and mount UEFI ESP
for i in ${DISK}; do
 mkfs.vfat -n EFI ${i}-part1
 mkdir -p /mnt/boot/efis/${i##*/}-part1
 mount -t vfat ${i}-part1 /mnt/boot/efis/${i##*/}-part1
done

mkdir -p /mnt/boot/efi
mount -t vfat $(echo $DISK | cut -f1 -d\ )-part1 /mnt/boot/efi

echo Do you want to continue? Press Ctrl+C to abort!
read foo


mkdir -p /mnt/etc/zfs/
rm -f /mnt/etc/zfs/zpool.cache
touch /mnt/etc/zfs/zpool.cache
chmod a-w /mnt/etc/zfs/zpool.cache
chattr +i /mnt/etc/zfs/zpool.cache
