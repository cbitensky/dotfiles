#!/bin/sh
exec scp -i /daglabs/katnip.pem -o ConnectTimeout=5 $1 ec2-user@18.225.37.149:$1
