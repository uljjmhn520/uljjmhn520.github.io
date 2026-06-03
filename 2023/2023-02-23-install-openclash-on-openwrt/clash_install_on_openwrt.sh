#!/bin/bash
opkg update
CLASH_VERSION=0.45.157-beta
cd /tmp
wget https://github.com/vernesong/OpenClash/releases/download/v${CLASH_VERSION}/luci-app-openclash_${CLASH_VERSION}_all.ipk -O openclash.ipk
opkg install openclash.ipk
rm openclash.ipk
