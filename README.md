# CentOS7

## 概要

Vagrant を使って Oracle MV VirtualBox に CentOS7 の検証環境を作ることができます。  


## 動作環境

* Windows 10 Pro 20H2

* Oracle VM VirtualBox 6.1.22

* Git for Windows v2.31.1

* Vagrant 2.2.15
  * vagrant-disksize

* CentOS 7 2009


## 使用条件

* Vagrant の Provider(バックエンドの仮想化ルーツ)は Oracle VM VirtualBox 6.1.x を使用しています。  
* VirtualBox のホストオンリーアダプターが必要です。  
* ホストオンリーアダプターのIPv6設定が無効化されている必要があります。  
* vagrant に vagrant-disksize プラグインがインストールされている必要があります。  


## 使い方

### 1) git clone をします。  

```
C:\Users\hataya> git clone https://github.com/tsr-hataya/vagrant-centos7.git
C:\Users\hataya> cd vagrant-centos7
C:\Users\hataya\vagrant-centos7> 
```


### 2) ホストオンリーアダプターに割り当てられているネットワーク設定に合わせて修正をしてください。  

変更箇所1： `Vagrantfile` の `config.vm.network`  

```
Vagrant.configure("2") do |config|
    :
  config.vm.network "private_network", ip: "192.168.56.11"
    :
end
```

### 3) 必要に応じて設定ファイルを修正をしてください。  

仮想マシン名： `Vagrantfile` の `vb.name = "ubuntu-20.04-lxd"`  

仮想マシンのCPUコア数： `Vagrantfile` の `vb.cpus = "2"`  

仮想マシンのメモリ容量： `Vagrantfile` の `vb.memory = "1024"`  

仮想マシンのホスト名： `Vagrantfile` の `config.vm.hostname = "ubuntu-lxd"`  

仮想マシンが参照するDNSサーバー： `vagrant.sh.d/setup1-ubuntu.sh` の `{TASK1]`  


### 4) vagrant up します。  

```
C:\Users\hataya\vagrant-centos7> vagrant up
```

仮想マシンが作成され Vagrant によって Setup1～2 のセットアップスクリプトが実行されます。  
セットアップが完了し再起動したら出来上がりです。  


### 5) ログインします。  

```
C:\Users\hataya\vagrant-centos7> vagrant ssh
```

TeraTermなど普段利用しているターミナルソフトからログインする際は `vagrant ssh-config` コマンドで確認できる接続情報でログインできます。  



### 6) lxc コマンドでコンテナを作って遊んでください。  

作成したコンテナの eth0 は VirtualBox の NAT インターフェースに接続されます。  

作成したコンテナの eth1 は VirtualBox の ホストオンリーアダプターに接続されます。  
ネットワーク設定はないので、コンテナ作成後手動で割り当てる必要があります。


## 補足事項

* 使用している box は `generic/centos7` です。 `centos/7` はエラーが出て起動しませんでした。  

## 作成者

* 畑屋
* TSR株式会社
* hataya@tsr-company.com


