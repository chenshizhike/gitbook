#!/bin/bash
#bash 脚本 调用 docker gitbook
#cp gitbook.sh ~/.local/bin
#编辑~/.bashrc 添加alias gitbook='gitbook.sh'
function get_port()
{
    first_port=1000
    last_port=65535
    for ((port=$first_port; port<=$last_port; port++))
    do
        msg=`netstat -nlat|tail -n +3|awk '{print $4}'|grep $port`
        if [ "$msg"x == "x" ]; then
            echo $port
            return 0
        fi
    done

    if [ "$port" == 65536 ]; then
        return 1
    fi
}

if [ "$1" == serve ]; then
    port=`get_port`
    if [ "$?" != "0" ]; then 
        echo "port=$port,所有端口已占有！"
        exit 1
    fi
    docker run -d --rm -v `pwd`:/gitbook -p $port:$port gitbook --port $port serve
else
    docker run --rm -v `pwd`:/gitbook gitbook $1
fi
