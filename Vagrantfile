Vagrant.configure("2") do |config|
  
  config.vm.box = "generic/centos7"
  config.vm.network "private_network", ip: "192.168.56.11"
  config.vm.hostname = "centos7"
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder "./vagrant.conf", "/vagrant.conf", create: true
  config.disksize.size = "40GB"
  
  config.vm.provider "virtualbox" do |vb|
    vb.name = "centos7"
    vb.gui = true
    vb.cpus = 2
    vb.memory = "1024"
    vb.customize [
        "modifyvm", :id,
        "--graphicscontroller", "VMSVGA",
        "--audio", "none",
        "--uart1", "off",
        "--uart2", "off",
        "--uart3", "off",
        "--uart4", "off",
        "--usb", "off",
        "--nicpromisc2", "allow-all"
    ]
  end
  
  config.vm.provision "shell", inline: <<-SHELL
    echo "--------------------"
    echo "disable firewalld"
    echo "--------------------"
    systemctl disable firewalld
    echo ""
    echo "complete."
    echo ""
    
    echo "--------------------"
    echo "disable ipv6"
    echo "--------------------"
    cp /vagrant.conf/disable_ipv6.conf /etc/sysctl.d/disable_ipv6.conf
    echo ""
    echo "complete."
    echo ""
    
    echo "--------------------"
    echo "disable SELinux"
    echo "--------------------"
    sed -i.`date '+%Y%m%d-%H%M%S'` 's/^SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
    echo ""
    echo "complete."
    echo ""
    
    echo "--------------------"
    echo "system update"
    echo "--------------------"
    yum clean all
    yum update -y
    echo ""
    echo "complete."
    echo ""
    
    echo "--------------------"
    echo "install packages"
    echo "--------------------"
    yum install -y wget zip unzip bind-utils tree lsof man man-pages-ja
    echo ""
    echo "complete."
    echo ""
    
    echo "--------------------"
    echo "set ntp server"
    echo "--------------------"
    cp /etc/chrony.conf /etc/chrony.conf.`date '+%Y%m%d-%H%M%S'`
    sed -i 's/^server 0.centos.pool.ntp.org iburst/server ntp.nict.jp iburst/' /etc/chrony.conf
    sed -i 's/^server 1.centos.pool.ntp.org iburst/server ntp.jst.mfeed.ad.jp iburst/' /etc/chrony.conf
    sed -i '/^server 2.centos.pool.ntp.org/d' /etc/chrony.conf
    sed -i '/^server 3.centos.pool.ntp.org/d' /etc/chrony.conf
    echo ""
    echo "complete."
    echo ""
    
    echo "--------------------"
    echo "set timezone"
    echo "--------------------"
    timedatectl set-timezone Asia/Tokyo
    echo ""
    echo "complete."
    echo ""
    
    # set locale
    echo "--------------------"
    echo "set locale"
    echo "--------------------"
    localectl set-locale LANG=ja_JP.UTF-8
    cat /vagrant.conf/set-locale.txt >> /etc/bashrc
    echo ""
    echo "complete."
    echo ""
    
    # reboot
    echo "--------------------"
    echo "reboot"
    echo "--------------------"
    echo "The setup process is complete."
    echo "Reboot the server. Please wait for a little while."
    echo ""
    shutdown -r now
    
  SHELL

end