###########################
### Profile definitions ###
###########################

### Class: profile::base
class profile::base {
  include default_packages
  include puppet_agent
  include cron
  include accounts
  include sudo
  include ssh
  include unattended_upgrades
  include ohmyzsh
}

### Class: profile::raspberry_pi
class profile::raspberry_pi {
  exec { '/usr/sbin/dphys-swapfile uninstall':
    unless => '/bin/sh -c "! /usr/sbin/swapon --show | grep file >/dev/null 2>&1"',
  }
}

node 'rpi-4gb.homelab.example' {
  include profile::raspberry_pi
  include profile::base
}

node 'rpi-8gb.homelab.example' {
  include profile::raspberry_pi
  include profile::base
  include r10k
  include hiera
  include docker
  # include zabbix
  # include zabbix::agent
  host { 'puppet':
    ensure => 'present',
    name   => 'puppetserver.homelab.example',
    ip     => '127.0.0.1',
  }
  # file { '/mnt/media_01':
  #   ensure => directory,
  #   mode   => '0755',
  # }
  # mount { '/mnt/media_01':
  #   ensure  => mounted,
  #   name    => '/mnt/media_01',
  #   atboot  => false,
  #   device  => '/dev/sda1',
  #   fstype  => 'vfat',
  #   options => 'uid=1000,gid=1000',
  #   dump    => 0,
  #   pass    => 0,
  #   require => File['/mnt/media_01'],
  # }
  # file { '/mnt/media_02':
  #   ensure => directory,
  #   mode   => '0755',
  # }
  # mount { '/mnt/media_02':
  #   ensure  => mounted,
  #   name    => '/mnt/media_02',
  #   atboot  => false,
  #   device  => '/dev/sda2',
  #   fstype  => 'vfat',
  #   options => 'uid=1000,gid=1000',
  #   dump    => 0,
  #   pass    => 0,
  #   require => File['/mnt/media_02'],
  # }
}
