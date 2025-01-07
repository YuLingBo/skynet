#!/bin/bash
ps  -efww|grep skynet|grep -v grep|cut -c 9-15|xargs kill -9

# 查询所有占用端口
netstat -unltp


test ## 测试日志
1111111

结论：
git revert 是回退到最后一次提交的版本