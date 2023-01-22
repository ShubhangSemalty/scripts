#!/usr/bin/expect -f

set timeout 30

set prodpass "$env(PROD_LDAP_PASSWORD)"
set reveriepass "$env(REVERIE_DB_PASSWORD)"
set mysqlpass "$env(MYSQL_DB_PASSWORD)"
set jump "$env(JUMP_HOST)"
set dbjump "$env(DB_JUMP)"
set mysqlcmd "$env(MYSQL_CMD)"

spawn ssh $jump
expect "password: "
send "$prodpass\r"

expect "$ " {send "ssh $dbjump\r"}
expect "yes/no" {
send "yes\r"
expect "*?assword" { send "$reveriepass\r" }
expect "$ " {send "$mysqlcmd\r"}
expect "*?assword" { send "$mysqlpass\r" }
expect "mysql" {send "use reverie;\r"}
}

interact