#!/usr/local/bin/bats
@test "1.1.1 - Hostname is set correctly" {
   hostname | grep 'controller'*[1-2]*
}

@test "1.1.2 - controller connects to internet" {
  ping -q -c1 google.com
  }

@test "1.1.3 - SElinux is disabled" {
  sestatus | grep 'Mode from config file' | egrep disabled
  }

@test "1.1.4 - firewall is disabled" {
  systemctl status firewall | grep inactive
  }

@test "1.1.5 - chronyd is running" {
  systemctl status chronyd.service
  }

@test "1.1.6 - RDMA is running" {
  systemctl status rdma.service
  }

@test "1.1.7 - NFS-server is configured" {
   systemctl status nfs-server
   }

@test "1.1.8 - LDAP for authentication is configured" {
   systemctl status slapd   
}

@test "1.1.9 - Controller is configured to use SSSD" {
   systemctl status sssd.service
}

@test "1.1.10 - The database are started and running" {
   systemctl status mariadb
   systemctl status mongod
   }

@test "1.1.11 - Slurm and Munge are started and running" {
   systemctl status slurm
   systemctl status munge
   }

@test "1.1.12 - The dhcp server is running" {
  systemctl status dhcpd
  }


@test "1.1.13 - Monitoring server is running" {
  systemctl status zabbix-server
  }


@test "1.1.13 - DNS is working on the controller" {
   skip Not yet in luna
   host controller localhost
}
@test "1.1.13 - DRBD is configured" {
   skip Not yet in configuration
   systemctl status drbd.service
   }
