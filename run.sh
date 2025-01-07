#!/bin/bash
if [ "$1" == "exa" ];then
     echo "starting examples"
    ./skynet examples/config
elif [ "$1" == "node1" ];then
    echo "starting config"
    ./skynet config/config.node1
else
    echo "starting config2"
    ./skynet config/config.node2
fi

    
