#!/bin/bash
ps  -efww|grep skynet|grep -v grep|cut -c 9-15|xargs kill -9

# 查询所有占用端口
netstat -unltp

# 测试 git 
1111111

2222222


333333