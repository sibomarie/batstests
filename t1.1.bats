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


@test "1.1.14 - DNS is working on the controller" {
   skip "Not yet in luna"
   host controller localhost
}
@test "1.1.15 - DRBD is configured" {
   skip "Not yet in configuration"
   systemctl status drbd.service
   }

@test "1.1.16 - RABBITMQ is running and cluster is up" {
   systemctl status rabbit-server.service
   rabbitmqctl status | grep running_nodes | grep rabbit@${hostname}
   rabbitmqctl list_users | grep openstack
  }
@test "1.1.17 - the appropriate openstack services are active" {
   status=$(openstack-status)
   echo $status | grep "nova-api:[ ]*active"
   echo $status | grep "nova-compute:[ ]*active"
   echo $status | grep "nova-neutron-server:[ ]*active"
   echo $status | grep "nova-neutron-dhcp-agent:[ ]*active"
   echo $status | grep "nova-scheduler:[ ]*active"
   echo $status | grep "openstack-dashboard:[ ]*active"
   echo $status | grep "dbus:[ ]*active"
   echo $status | grep "memcached:[ ]*active"
   echo $status | grep "openstack-cinder-api:[ ]*active"
   echo $status | grep "openstack-cinder-scheduler:[ ]*active"
   echo $status | grep "rabbitmq-server:[ ]*active"
   echo $status | grep "openstack-glance-registry:[ ]*active"
   echo $status | grep "openstack-glance-api:[ ]*active"
  }
