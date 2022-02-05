#!/bin/bash
echo update
sudo apt-get update
echo upgrade 
sudo apt-get upgrade
echo  Doker 
sudo apt-get install docker-ce docker-ce-cli containerd.io
echo nGinX
sudo docker pull nginx
