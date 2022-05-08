#!/bin/sh
exec scp -i /daglabs/katnip.pem -o ConnectTimeout=5 $1 ec2-user@3.143.57.71:$1
