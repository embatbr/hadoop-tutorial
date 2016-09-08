#!/bin/bash


cd $HOME

read -p "Input the command (format | start | stop): " CMD

if [ "$CMD" == "format" ]; then
    echo ">> Formatting HDFS"
    hdfs namenode -format
elif [ "$CMD" == "start" ]; then
    # if necessary, do `sudo apt-get install openssh-server`
    echo ">> Starting DFS"
    start-dfs.sh

    echo ">> Starting YARN"
    start-yarn.sh

    echo ">> google-chrome http://localhost:50070/"
    google-chrome http://localhost:50070/

    echo ">> google-chrome http://localhost:8088/"
    google-chrome http://localhost:8088/
elif [ "$CMD" == "stop" ]; then
    echo ">> Stopping YARN"
    stop-yarn.sh

    echo ">> Stopping DFS"
    stop-dfs.sh
fi
