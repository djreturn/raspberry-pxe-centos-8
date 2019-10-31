# Raspberry PXE setup for Centos-8

## Description

This is a simple setup of PXE Server from Rasperry PI connected in local network that will make netboot and install Centos 8.

## Requirments and info

* DHCP server router on IP: 192.168.1.254
* Rasperry PI with at least 8Gb SD card on IP: 192.168.1.1
* Raspberry info
```# uname -a
Linux raspberrypi 4.19.75-v7+ #1270 SMP Tue Sep 24 18:45:11 BST 2019 armv7l GNU/Linux
```
* VirtualBox, VMware, Hyper-V for testing boot
* Default password is passwored123

__Note:__
* __This will overwrite your current vsftpd configuration__
* __This will overwrite your current dnsmasq configuration__

## Architecture
(img)
## Installation 
Tere are three ways installing it.

### Ansible installation

### Docker Installation

### Manual Installastion
1. Install packages:
```
apt install vsftpd dnsmasq wget rpm2cipo git
```

2. Download CentOS 8 DVD ISO:
```
wget http://mozart.ee.ic.ac.uk/CentOS/8.0.1905/isos/x86_64/CentOS-8-x86_64-1905-dvd1.iso
```

3. Download this repository:
```
git clone https://github.com/spagu/raspberry-pxe-centos-8.git
```

4. Set up folders
```
mkdir -p /srv/isos/centos
mkdir -p /srv/ftpd
chown nobody:nogroup /srv/
```

5. Mount DVD into a folder
```
mount -o loop CentOS-8-x86_64-1905-dvd1.iso /srv/isos/centos
```

6. Get boot files
```mkdir -p /tmp/bootfiles
cp /srv/isos/centos/BaseOS/Packages/syslinux-* /tmp/bootfiles
cd /tmp/bootfiles
rpm2cpio syslinux-6.04-1.el8.noarch.rpm | cpio -idmv
rpm2cpio syslinux-tftpboot-6.04-1.el8.noarch.rpm | cpio -idmv
```
7. Copy relevant files into locations


8. Start services
```
systemctl start vsftpd
systemctl enable vsftpd
systemctl start dnsmasq
systemctl enable dnsmasq
```

### Notes
#### Other password

You can generate new password by doing command:
```
# openssl passwd -1 password123
$1$e4wrrGGX$tZPQKPsXjhNmbiGg53M441
#
```
then change it in kickstart file `/srv/isos/centos8.ks`


## References
- http://isoredirect.centos.org/centos/8/isos/x86_64/CentOS-8-x86_64-1905-dvd1.iso
- https://bashtheshell.com/guide/setting-up-pxe-boot-server-on-raspberry-pi/
- https://www.linuxtechi.com/configure-pxe-installation-server-centos-7/
- https://cspracs.wordpress.com/pxe-boot/
- https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/installation_guide/s1-kickstart2-options

