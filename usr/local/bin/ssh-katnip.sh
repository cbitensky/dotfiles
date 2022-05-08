#!/bin/sh
TERM=xterm-256color exec ssh -o ConnectTimeout=5 ec2-user@3.143.57.71 -i /daglabs/katnip.pem
