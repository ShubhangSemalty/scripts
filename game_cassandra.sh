#!/usr/bin/expect -f

set timeout 30

set prodpass "$env(PROD_LDAP_PASSWORD)"
set jump "$env(JUMP_HOST)"
set cassandra "$env(gameplay)"

spawn ssh $jump
expect "password: "
send "$prodpass\r"

expect "$ " {send "ssh $cassandra\r"}
expect "yes/no" {
send "yes\r"
expect "*?assword" { send "$prodpass\r"}
expect "*$ " {send "cd /data/cassandra/bin\r"}
expect "*$ " {send "./cqlsh\r"}
expect "cqlsh>" {send "use fantasy_keyspace;\r"}
expect "cqlsh:fantasy_keyspace>" {send "describe tables;\r"}
}


interact