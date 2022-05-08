#!/bin/sh
exec scp -i /daglabs/katnip.pem -o ConnectTimeout=5 $1 ec2-user@18.117.150.182:$1
