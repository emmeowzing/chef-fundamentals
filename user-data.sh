#! /bin/bash

LOC="/home/ubuntu"

apt update
apt upgrade -y

wget https://packages.chef.io/files/stable/chefdk/4.7.73/ubuntu/18.04/chefdk_4.7.73-1_amd64.deb -O "$LOC/chefdk.deb"
dpkg -i "$LOC/chefdk.deb"

mkdir "$LOC/chef_repo/"

