#!/usr/bin/expect -f

set timeout 30

set prodpass "$env(PROD_LDAP_PASSWORD)"
#set redis_type [lindex $argv 0];
set jump "$env(JUMP_HOST)"
set redis "$env(REDIS_JUMP)"

spawn ssh $jump
expect "password: "
send "$prodpass\r"

expect "$ " {send "ssh $redis\r"}
expect "yes/no" {
send "yes\r"
expect "*?assword" { send "$prodpass\r"}
}

interact