### NixOS OpenZFS setup (from the OpenZFS homepage)


#### Preparation

- Disable Secure Boot. ZFS modules can not be loaded if Secure Boot is enabled.

 **Target disk**

- List available disks with:

    ```bash
    ls /dev/disk/by-id/*
    ```
If using virtio as disk bus, use /dev/disk/by-path/*.

- Declare disk array:

    ```bash
    DISK='/dev/disk/by-id/ata-FOO /dev/disk/by-id/nvme-BAR'
    ```

    For single disk installation, use:

    ```bash
    DISK='/dev/disk/by-id/disk1'
    ```

- Set partition size:

- Set swap size. It’s recommended to setup a swap partition. If you intend to use hibernation, the minimum should be no less than RAM size. Skip if swap is not needed:

    ```bash
    INST_PARTSIZE_SWAP=8
    ```

- Root pool size, use all remaining disk space if not set:

    ```bash
    INST_PARTSIZE_RPOOL=
    ```

#### System installation

    

**Partition the disks:**


    ```bash
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
    ```

- Create boot pool:

    ```bash
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
        mirror \
        $(for i in ${DISK}; do
           printf "$i-part2 ";
          done)
    ```

If not using a multi-disk setup, remove mirror.

You should not need to customize any of the options for the boot pool.

GRUB does not support all of the zpool features. See spa_feature_names in grub-core/fs/zfs/zfs.c. This step creates a separate boot pool for /boot with the features limited to only those that GRUB supports, allowing the root pool to use any/all features.

Features enabled with -o compatibility=grub2 can be seen here.

- Create root pool:

    ```bash
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
        rpool \
        mirror \
       $(for i in ${DISK}; do
          printf "$i-part3 ";
         done)
    ```

If not using a multi-disk setup, remove mirror.

This section implements dataset layout as described in overview.

- Create root system container:

Unencrypted:


    ```bash
        zfs create \
         -o canmount=off \
         -o mountpoint=none \
         rpool/nixos
    ```

Encrypted:

Pick a strong password. Once compromised, changing password will not keep your data safe. See zfs-change-key(8) for more info:


    ```bash
        zfs create \
         -o canmount=off \
         -o mountpoint=none \
         -o encryption=on \
         -o keylocation=prompt \
         -o keyformat=passphrase \
         rpool/nixos
    ```

- Create system datasets:


    ```bash
    zfs create -o canmount=on -o mountpoint=/     rpool/nixos/root
    zfs create -o canmount=on -o mountpoint=/home rpool/nixos/home
    zfs create -o canmount=off -o mountpoint=/var  rpool/nixos/var
    zfs create -o canmount=on  rpool/nixos/var/lib
    zfs create -o canmount=on  rpool/nixos/var/log
    ```

- Create boot dataset:


    ```bash
    zfs create -o canmount=off -o mountpoint=none bpool/nixos
    zfs create -o canmount=on -o mountpoint=/boot bpool/nixos/root
    ```

- Format and mount ESP:


    ```bash
    for i in ${DISK}; do
     mkfs.vfat -n EFI ${i}-part1
     mkdir -p /mnt/boot/efis/${i##*/}-part1
     mount -t vfat ${i}-part1 /mnt/boot/efis/${i##*/}-part1
    done

    mkdir -p /mnt/boot/efi
    mount -t vfat $(echo $DISK | cut -f1 -d\ )-part1 /mnt/boot/efi
    ```
#### System Configuration

- Disable cache, stale cache will prevent system from booting:


    ```bash
    mkdir -p /mnt/etc/zfs/
    rm -f /mnt/etc/zfs/zpool.cache
    touch /mnt/etc/zfs/zpool.cache
    chmod a-w /mnt/etc/zfs/zpool.cache
    chattr +i /mnt/etc/zfs/zpool.cache
    ```

- Generate initial system configuration:


    ```bash
    nixos-generate-config --root /mnt
    ```

- Import ZFS-specific configuration:


    ```bash
    sed -i "s|./hardware-configuration.nix|./hardware-configuration.nix ./zfs.nix|g" /mnt/etc/nixos/configuration.nix
    ```

- Configure hostid:


    ```bash
    tee -a /mnt/etc/nixos/zfs.nix <<EOF
    { config, pkgs, ... }:

    { boot.supportedFilesystems = [ "zfs" ];
      networking.hostId = "$(head -c 8 /etc/machine-id)";
      boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    EOF
    ```

- Configure bootloader for both legacy boot and UEFI boot and mirror bootloader:


    ```bash
    sed -i '/boot.loader/d' /mnt/etc/nixos/configuration.nix
    sed -i '/services.xserver/d' /mnt/etc/nixos/configuration.nix
    tee -a /mnt/etc/nixos/zfs.nix <<-'EOF'
    boot.loader.efi.efiSysMountPoint = "/boot/efi";
    boot.loader.efi.canTouchEfiVariables = false;
    boot.loader.generationsDir.copyKernels = true;
    boot.loader.grub.efiInstallAsRemovable = true;
    boot.loader.grub.enable = true;
    boot.loader.grub.version = 2;
    boot.loader.grub.copyKernels = true;
    boot.loader.grub.efiSupport = true;
    boot.loader.grub.zfsSupport = true;
    boot.loader.grub.extraPrepareConfig = ''
      mkdir -p /boot/efis
      for i in  /boot/efis/*; do mount $i ; done

      mkdir -p /boot/efi
      mount /boot/efi
    '';
    boot.loader.grub.extraInstallCommands = ''
    ESP_MIRROR=$(mktemp -d)
    cp -r /boot/efi/EFI $ESP_MIRROR
    for i in /boot/efis/*; do
     cp -r $ESP_MIRROR/EFI $i
    done
    rm -rf $ESP_MIRROR
    '';
    boot.loader.grub.devices = [
    EOF

    for i in $DISK; do
      printf "      \"$i\"\n" >>/mnt/etc/nixos/zfs.nix
    done

    tee -a /mnt/etc/nixos/zfs.nix <<EOF
        ];
    EOF
    ```

- Mount datasets with zfsutil option:


    ```bash
    sed -i 's|fsType = "zfs";|fsType = "zfs"; options = [ "zfsutil" "X-mount.mkdir" ];|g' \
    /mnt/etc/nixos/hardware-configuration.nix
    ```

- Set root password:


    ```bash
    rootPwd=$(mkpasswd -m SHA-512 -s)
    ```

- Declare password in configuration:


    ```bash
    tee -a /mnt/etc/nixos/zfs.nix <<EOF
    users.users.root.initialHashedPassword = "${rootPwd}";
    }
    EOF
    ```

- Install system and apply configuration:


    ```bash
    nixos-install -v --show-trace --no-root-passwd --root /mnt
    ```

- Unmount filesystems:


    ```bash
    umount -Rl /mnt
    zpool export -a
    ```

- Reboot!
