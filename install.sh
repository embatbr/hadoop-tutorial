#!/bin/bash


PROJECT_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MODE="$1"

echo "Installation mode: $MODE"

cd $HOME/.ssh

if [ ! -f "id_rsa.pub" ]; then
    echo "RSA key generated"
    ssh-keygen -t rsa
fi
cat id_rsa.pub >> authorized_keys
chmod 0600 authorized_keys

cd $HOME/apps

HADOOP_HOME="$HOME/apps/hadoop"
HADOOP_VERSION="2.7.3"

echo "Cleaning previous installation"
if [ -d "./hadoop-$HADOOP_VERSION" ]; then
    rm -Rf $(readlink $HADOOP_HOME)
fi
if [ -L "./hadoop" ]; then
    rm -Rf $HADOOP_HOME
fi
if [ -f "./hadoop-$HADOOP_VERSION.tar.gz" ]; then
    rm hadoop-$HADOOP_VERSION.tar.gz
fi

echo "Downloading Hadoop version $HADOOP_VERSION"
wget http://mirror.nbtelecom.com.br/apache/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz
tar xzf hadoop-$HADOOP_VERSION.tar.gz
rm hadoop-$HADOOP_VERSION.tar.gz
ln -s hadoop-$HADOOP_VERSION hadoop

HADOOP_BASH_IMPORT_PATH="./hadoop/bashrc_import.sh"
touch $HADOOP_BASH_IMPORT_PATH
truncate -s 0 $HADOOP_BASH_IMPORT_PATH
chmod +x $HADOOP_BASH_IMPORT_PATH

echo "export HADOOP_HOME=\"$HADOOP_HOME\"" >> $HADOOP_BASH_IMPORT_PATH
if [ "$MODE" == "pseudo-distributed" ]; then
    echo "export HADOOP_MAPRED_HOME=$HADOOP_HOME" >> $HADOOP_BASH_IMPORT_PATH
    echo "export HADOOP_COMMON_HOME=$HADOOP_HOME" >> $HADOOP_BASH_IMPORT_PATH
    echo "export HADOOP_HDFS_HOME=$HADOOP_HOME" >> $HADOOP_BASH_IMPORT_PATH
    echo "export YARN_HOME=$HADOOP_HOME" >> $HADOOP_BASH_IMPORT_PATH
    echo "export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native" >> $HADOOP_BASH_IMPORT_PATH
    echo "export HADOOP_INSTALL=$HADOOP_HOME" >> $HADOOP_BASH_IMPORT_PATH
    echo "export HADOOP_OPTS=\"$HADOOP_OPTS -Djava.library.path=$HADOOP_HOME/lib/native\"" >> $HADOOP_BASH_IMPORT_PATH
fi
echo "export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin" >> $HADOOP_BASH_IMPORT_PATH

echo "Don't forget to \`source ~/.bashrc\`."
