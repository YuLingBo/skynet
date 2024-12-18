<<<<<<< HEAD
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

    
=======
./skynet config/config.node1
>>>>>>> parent of dc71f93 (上传 snax 框架学习案例)
