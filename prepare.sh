#!/bin/bash
if [ ! -f TrinityX.pdf ]; then
  echo "Please run from within the cloned TrinityX folder"
else
  # To disable SElinux on the controller node
  setenforce 0
  sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config

  yum update -y
  yum install epel-release -y
  yum install curl tar ansible git epel-release -y

  if [ ! -f site/hosts ]; then
    echo "Please modify the site/hosts.example and save it as site/hosts"  
  else
    if ! grep -q "^$(hostname -s)\s*" site/hosts; then
      echo "Please note the hostnames are not matching (see site/hosts)."
    fi
  fi
  if [ ! -f site/group_vars/all.yml ]; then
     echo "Please modify the site/group_vars/all.yml.example and save it as site/group_vars/all.yml"
  else
    if ! grep -q "^trix_ctrl1_hostname:\s*$(hostname -s)\s*$" site/group_vars/all.yml; then
      echo "Please note the hostnames are not matching (see site/group_vars/all.yml)."
    fi
  fi
  echo
  echo "#### Please configure the network before starting Ansible ####"
fi
