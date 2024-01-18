#!/bin/bash

ssh-keygen -R k0s-ctl1-dom114.mar.eosn.io
ssh-keygen -R k0s-ctl2-dom114.mar.eosn.io
ssh-keygen -R k0s-ctl3-dom114.mar.eosn.io
ssh-keygen -R dom115.mar.eosn.io
ssh-keygen -R dom116.mar.eosn.io

ssh-keygen -R "172.22.126.51"
ssh-keygen -R "172.22.126.52"
ssh-keygen -R "172.22.126.53"
ssh-keygen -R "172.22.1.115"
ssh-keygen -R "172.22.1.116"
ssh-keygen -R "172.22.126.11"

ssh-keygen -R k0s-ctl1-dom4.lab.eosn.io
ssh-keygen -R k0s-ctl2-dom4.lab.eosn.io
ssh-keygen -R k0s-ctl3-dom4.lab.eosn.io
ssh-keygen -R k0s-wk1-dom4.lab.eosn.io
ssh-keygen -R dom5.lab.eosn.io

ssh-keygen -R "172.21.3.2"
ssh-keygen -R "172.21.3.3"
ssh-keygen -R "172.21.3.4"
ssh-keygen -R "172.21.3.5"
ssh-keygen -R "172.21.1.5"