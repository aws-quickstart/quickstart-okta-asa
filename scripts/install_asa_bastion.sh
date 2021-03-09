#!/bin/bash

## FUNCTIONS
function install_asa_deb(){
  sudo wget "https://dist.scaleft.com/server-tools/linux/latest/scaleft-server-tools_latest_amd64.deb"
  sudo dpkg -i -E ./scaleft-server-tools_latest_amd64.deb
  sudo rm ./scaleft-server-tools_latest_amd64.deb
}

function install_asa_rpm(){
  sudo curl "https://dist.scaleft.com/server-tools/linux/latest/scaleft-server-tools-latest.x86_64.rpm" -v -O -L
  sudo rpm -ihv ./scaleft-server-tools-latest.x86_64.rpm
  sudo rm ./scaleft-server-tools-latest.x86_64.rpm
}

function restart_asa(){
  case "${BASTION_OS}" in
    Amazon)
      sudo /usr/sbin/service sftd restart
      ;;
    CentOS|SLES)
      sudo /sbin/service sftd restart
      ;;
    Ubuntu)
      sudo service sftd restart
      ;;
  esac
}

## CODE

# STEP 1: INSTALL ASA SERVER AGENT
case "${BASTION_OS}" in
    Ubuntu)
      install_asa_deb
      ;;
    CentOS|Amazon|SLES)
      install_asa_rpm
      ;;
esac

# STEP 2: CREATE CONFIG FILES
sudo mkdir -p /var/lib/sftd
echo "${ENROLLMENT_TOKEN}" | sudo tee /var/lib/sftd/enrollment.token
sudo mkdir -p /etc/sft/
sftcfg=$(cat <<EOF
---
CanonicalName: "${BASTION_HOSTNAME}"
EOF
)
echo -e "$sftcfg" | sudo tee /etc/sft/sftd.yaml

# STEP 3: RESTART ASA
restart_asa
echo "ASA Setup completed."