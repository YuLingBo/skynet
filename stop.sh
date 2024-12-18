#!/bin/bash
ps  -efww|grep skynet|grep -v grep|cut -c 9-15|xargs kill -9

# 查询所有占用端口
netstat -unltp

USE mysql;
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '123456';
FLUSH PRIVILEGES;


ALTER USER 'root'@'localhost' IDENTIFIED BY '123456';
