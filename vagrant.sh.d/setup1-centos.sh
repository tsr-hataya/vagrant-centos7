#!/bin/bash

echo ""
echo "==>>"
echo "==>> [SETUP1] Initial setup of CentOS 7."
echo "==>>"
echo ""

# ----- [TASK1] -----
echo "==> [TASK1] Disable firewalld."
systemctl disable firewalld
echo ""

# ----- [TASK2] -----
echo "==> [TASK2] Disable ipv6."
cp /vagrant.conf.d/disable_ipv6.conf /etc/sysctl.d/disable_ipv6.conf
echo ""

# ----- [TASK3] -----
echo "==> [TASK3] Disable SELinux."
sed -i.`date '+%Y%m%d-%H%M%S'` 's/^SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
echo ""

# ----- [TASK4] -----
echo "==> [TASK4] System update."
yum clean all
yum update -y
echo ""

# ----- [TASK5] -----
echo "==> [TASK5] Install some packages."
yum install -y wget zip unzip bind-utils tree lsof pciutils usbutils man man-pages-ja
echo ""

# ----- [TASK6] -----
echo "==> [TASK6] Set up some NTP servers."
cp /etc/chrony.conf /etc/chrony.conf.`date '+%Y%m%d-%H%M%S'`
sed -i 's|^server 0.centos.pool.ntp.org iburst|server ntp.nict.jp iburst|' /etc/chrony.conf
sed -i 's|^server 1.centos.pool.ntp.org iburst|server ntp.jst.mfeed.ad.jp iburst|' /etc/chrony.conf
sed -i '|^server 2.centos.pool.ntp.org|d' /etc/chrony.conf
sed -i '|^server 3.centos.pool.ntp.org|d' /etc/chrony.conf
echo ""

# ----- [TASK7] -----
echo "==> [TASK7] Set the time zone."
timedatectl set-timezone Asia/Tokyo
echo ""

# ----- [TASK8] -----
echo "==> [TASK8] Set the locale."
localectl set-locale LANG=ja_JP.UTF-8
cat /vagrant.conf.d/set-locale.txt >> /etc/bashrc
echo ""


