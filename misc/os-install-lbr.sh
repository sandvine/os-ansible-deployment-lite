#! /bin/bash

# Copyright 2016, Sandvine Incorporated.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


FQDN=$(hostname -f)


clear


echo
echo "Welcome to OpenStack Kilo Deployment!"
echo


echo
echo "Installing Git and Ansible..."
echo
sudo apt-get install -y git ansible=1.7.2+dfsg-1~ubuntu14.04.1


echo
echo "Cloning OpenStack Ansible Deployment Lite into your home directory..."
echo
cd ~
git clone -b kilo https://github.com/sandvine/os-ansible-deployment-lite.git


echo
echo "Deploying OpenStack..."
echo
echo "Bridge Mode: Linux Bridges"
echo
cd ~/os-ansible-deployment-lite
./os-deploy.sh LBR


echo
echo "Well done!"
echo
echo "Point your browser to http://$FQDN/horizon"
echo
echo "The credentials for both admin and demo users are stored at the"
echo "admin-openrc.sh and demo-openrc.sh files located inside your home."
echo
echo "You can now launch your Stacks! Be it a NFV L2 Bridge or just a Wordpress."
echo "There are a few examples here at your home, for example, you can try:"
echo
echo "source ~/demo-openrc.sh"
echo
echo "If you have 8~16G of RAM:"
echo "heat stack-create demo -f ~/os-ansible-deployment-lite/misc/os-heat-templates/sandvine-stack-0.1-centos-medium.yaml"
echo "heat stack-create demo -f ~/os-ansible-deployment-lite/misc/os-heat-templates/sandvine-stack-0.1-centos-large.yaml"
echo
echo "If you have 2~4G of RAM:"
echo "heat stack-create demo -f ~/os-ansible-deployment-lite/misc/os-heat-templates/nfv-l2-bridge-basic-stack-ubuntu-little.yaml"
echo "heat stack-create demo -f ~/os-ansible-deployment-lite/misc/os-heat-templates/nfv-l2-bridge-basic-stack-debian-little.yaml"
echo
echo "Enjoy it!"
echo
