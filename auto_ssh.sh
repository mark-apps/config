#!/bin/bash
#set timeout 3
HOST=$1
PORT=22
USERNAME=root
PASSWORD=$2

/usr/bin/expect <<-EOF

spawn ssh ${USERNAME}@${HOST}
expect { 
	"*password" {
		send "${PASSWORD}\r"
	}
	"*(yes/no/*)?*" {
		send "yes\r"
		expect { 
			"*password*" {
		                send "${PASSWORD}\r"
			}
		}
	}
}
interact

EOF

