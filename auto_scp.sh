#!/usr/bin/expect 
#使用第一个参数 
set server_ip [lindex $argv 0] 
#后面的也可以用参数[lindex $argv n] 
set server_port 22 
set server_dir /home/test
set server_user test
set server_pswd test
set scp_file auto_scp.sh 
                                                
# 设置超时时间 
set timeout 60 
spawn scp -P $server_port $scp_file $server_user@$server_ip:$server_dir 
expect { 
    "passphrase"
    { 
      send "$server_pswd\n"; 
    } 
    "password"
    { 
       send "$server_pswd\n"; 
    } 
    "yes/no"
    { 
       send "yes\n"; 
       exp_continue; 
    } 
} 
expect eof

