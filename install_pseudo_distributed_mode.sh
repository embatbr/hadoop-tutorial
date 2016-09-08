#!/bin/bash


PROJECT_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $PROJECT_ROOT
./install.sh "pseudo-distributed"

source $HOME/.bashrc
echo HADOOP_HOME: $HADOOP_HOME

# editing files in directory $HADOOP_HOME/etc/hadoop
CONFS_DIR="$HADOOP_HOME/etc/hadoop"
cd $CONFS_DIR
echo "Configuration of the following files in directory \"$CONFS_DIR\":"

CUR_FILE="hadoop-env.sh"
old="export JAVA_HOME=\${JAVA_HOME}"
new="export JAVA_HOME=\"$JAVA_HOME\""
sed -i "s|$old|$new|g" $CUR_FILE
echo $CUR_FILE

CUR_FILE="core-site.xml"
if [ ! -f "$CUR_FILE" ]; then
    touch $CUR_FILE
fi
truncate -s 0 $CUR_FILE
cat >> $CUR_FILE << EOM
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>


<configuration>
    <property>
        <name>fs.default.name</name>
        <value>hdfs://localhost:9000/home/embat/tmp/hadoop/storage</value>
   </property>
</configuration>
EOM
echo $CUR_FILE

CUR_FILE="hdfs-site.xml"
if [ ! -f "$CUR_FILE" ]; then
    touch $CUR_FILE
fi
truncate -s 0 $CUR_FILE
cat >> $CUR_FILE << EOM
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>


<configuration>
    <property>
        <name>dfs.replication</name>
        <value>1</value>
    </property>
    <property>
        <name>dfs.name.dir</name>
        <value>file:///home/embat/tmp/hadoop/infra/hdfs/namenode</value>
    </property>
    <property>
        <name>dfs.data.dir</name>
        <value>file:///home/embat/tmp/hadoop/infra/hdfs/datanode</value>
    </property>
</configuration>
EOM
echo $CUR_FILE

CUR_FILE="yarn-site.xml"
if [ ! -f "$CUR_FILE" ]; then
    touch $CUR_FILE
fi
truncate -s 0 $CUR_FILE
cat >> $CUR_FILE << EOM
<?xml version="1.0"?>


<configuration>
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>
</configuration>
EOM
echo $CUR_FILE

CUR_FILE="mapred-site.xml"
if [ ! -f "$CUR_FILE" ]; then
    touch $CUR_FILE
fi
truncate -s 0 $CUR_FILE
cat >> $CUR_FILE << EOM
<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>


<configuration>
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
</configuration>
EOM
echo $CUR_FILE

echo "Run file \`operate_hadoop.sh\` to operate the Hadoop cluster."
echo "Run file \`examples_pseudo_distributed_mode.sh\` to test Hadoop installation."
