#!/bin/bash


PROJECT_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

MAPREDUCE_EXAMPLES="$HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.3.jar"
EXAMPLE="wordcount"

echo "Leaving safemode"
hdfs dfsadmin -safemode leave

hadoop fs -test -d input/$EXAMPLE
if [ $? != 0 ]; then
    echo "Creating directory input/$EXAMPLE"
    hadoop fs -mkdir -p input/$EXAMPLE
fi

hadoop fs -test -d output
if [ $? != 0 ]; then
    echo "Creating directory output"
    hadoop fs -mkdir -p output
fi

hadoop fs -test -d output/$EXAMPLE
if [ $? == 0 ]; then
    echo "Cleaning last output for $EXAMPLE"
    hadoop fs -rm -r -f output/$EXAMPLE
fi

echo "Populating input"
hadoop fs -put $HADOOP_HOME/*.txt input/$EXAMPLE
echo "Content of input:"
hadoop fs -ls input/$EXAMPLE

hadoop jar $MAPREDUCE_EXAMPLES $EXAMPLE input/$EXAMPLE output/$EXAMPLE

echo "Retrieving information..."
rm -Rf $PROJECT_ROOT/output/$EXAMPLE
hadoop fs -get output/$EXAMPLE $PROJECT_ROOT/output/$EXAMPLE
