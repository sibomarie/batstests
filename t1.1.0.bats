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

@test "1.1.10 - The database are started and running" {
   systemctl status mariadb
   }

@test "1.1.16 - RABBITMQ is running and cluster is up" {
   systemctl status rabbitmq-server.service
   rabbitmqctl cluster_status | grep running_nodes | grep rabbit@${hostname}
   rabbitmqctl list_users | grep openstack
   }
@test "1.1.17 - the appropriate openstack services are active" {
   status=$(openstack-status)
   echo $status | grep "nova-api:[ ]*active"
   echo $status | grep "nova-neutron-server:[ ]*active"
   echo $status | grep "nova-neutron-dhcp-agent:[ ]*active"
   echo $status | grep "nova-scheduler:[ ]*active"
   echo $status | grep "openstack-dashboard:[ ]*active"
   echo $status | grep "dbus:[ ]*active"
   echo $status | grep "memcached:[ ]*active"
   echo $status | grep "openstack-cinder-api:[ ]*active"
   echo $status | grep "openstack-cinder-scheduler:[ ]*active"
   echo $status | grep "openstack-glance-registry:[ ]*active"
   echo $status | grep "openstack-glance-api:[ ]*active"
  }
