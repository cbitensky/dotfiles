#!/bin/sh
TERM=xterm-256color exec ssh -o ConnectTimeout=5 ec2-user@3.144.32.184 -i /daglabs/katnip.pem
