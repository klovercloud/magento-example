#!/bin/bash
set -e
echo '[INFO] Waiting for mounting persistent volume';
sleep 15s
######
#Adjust this section based on your needs
echo "[INFO] Removing replaceable files from /home/klovercloud/app";
######
echo "[INFO] Copying app files to /home/klovercloud/app";
cp -r /home/klovercloud/tmp/app /home/klovercloud
echo "[INFO] App files copied to /home/klovercloud/app";
sleep 3s
echo '[INFO] Config Initialization Completed';
