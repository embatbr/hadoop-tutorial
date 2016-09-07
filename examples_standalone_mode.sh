#!/bin/bash


source ~/.bashrc


PROJECT_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $PROJECT_ROOT

MAPREDUCE_EXAMPLES="$HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.3.jar"
EXAMPLE="wordcount"

if [ ! -d "input/$EXAMPLE" ]; then
    mkdir -p input/$EXAMPLE
fi

if [ ! -d "output" ]; then
    mkdir -p output
fi

if [ -d "output/$EXAMPLE" ]; then
    echo "Cleaning last output"
    rm -Rf output/$EXAMPLE
fi

cp $HADOOP_HOME/*.txt input/$EXAMPLE
hadoop jar $MAPREDUCE_EXAMPLES $EXAMPLE input/$EXAMPLE output/$EXAMPLE
