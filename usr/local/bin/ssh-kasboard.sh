#!/bin/sh
TERM=xterm-256color exec ssh -o ConnectTimeout=5 ec2-user@3.12.255.43 -i /daglabs/katnip.pem
