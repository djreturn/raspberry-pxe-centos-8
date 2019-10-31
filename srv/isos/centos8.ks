firewall --disabled
eula --agreed
install
url --url="ftp://192.168.1.1/centos/"
rootpw --iscrypted $1$lB6wUb/b$oRaUUZiNJNdfOTgS3JT3Sr
auth useshadow passalgo=sha512
text
firstboot --disable
keyboard uk
lang en_GB
reboot --eject
selinux --disabled
logging --level=info
skipx
timezone --utc Europe/London
bootloader --location=mbr
services --enabled=NetworkManager,sshd,chronyd
clearpart --all --initlabel
ntpservers=0.centos.pool.ntp.org,1.centos.pool.ntp.org,2.centos.pool.ntp.org,3.centos.pool.ntp.org
part swap --asprimary --fstype="swap" --size=1024
part /boot --fstype xfs --size=300
part pv.01 --size=1 --grow
volgroup root_vg01 pv.01
logvol / --fstype xfs --name=lv_01 --vgname=root_vg01 --size=1 --grow
%packages
@base
@core
chrony
openssh-clients
yum-cron
vim
%end
%addon com_redhat_kdump --disable --reserve-mb='auto'
%end
