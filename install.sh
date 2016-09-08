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
    rm -Rf ./hadoop-$HADOOP_VERSION
fi
if [ -L "$HADOOP_HOME" ]; then
    rm -Rf $HADOOP_HOME
fi
if [ -f "./hadoop-$HADOOP_VERSION.tar.gz" ]; then
    rm hadoop-$HADOOP_VERSION.tar.gz
fi

echo "Downloading Hadoop version $HADOOP_VERSION"
wget http://mirror.nbtelecom.com.br/apache/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz
tar xzf hadoop-$HADOOP_VERSION.tar.gz
rm hadoop-$HADOOP_VERSION.tar.gz
ln -s hadoop-$HADOOP_VERSION $HADOOP_HOME

cd $HADOOP_HOME

INSTALL_CFG_FILE="./install.cfg"
truncate -s 0 $INSTALL_CFG_FILE
echo "mode=$MODE" >> $INSTALL_CFG_FILE

HADOOP_BASH_IMPORT_PATH="./bashrc_import.sh"
touch $HADOOP_BASH_IMPORT_PATH
truncate -s 0 $HADOOP_BASH_IMPORT_PATH
chmod +x $HADOOP_BASH_IMPORT_PATH

echo "export HADOOP_HOME=\"\$HADOOP_HOME\"" >> $HADOOP_BASH_IMPORT_PATH
if [ "$MODE" == "pseudo-distributed" ]; then
    cat >> $HADOOP_BASH_IMPORT_PATH << EOM
export HADOOP_MAPRED_HOME="\$HADOOP_HOME"
export HADOOP_COMMON_HOME="\$HADOOP_HOME"
export HADOOP_HDFS_HOME="\$HADOOP_HOME"
export YARN_HOME="\$HADOOP_HOME"
export HADOOP_COMMON_LIB_NATIVE_DIR="\$HADOOP_HOME/lib/native"
export HADOOP_INSTALL="\$HADOOP_HOME"
export HADOOP_OPTS="\$HADOOP_OPTS -Djava.library.path=\$HADOOP_HOME/lib/native"
EOM
fi
echo "export PATH=\"\$PATH:\$HADOOP_HOME/sbin:\$HADOOP_HOME/bin\"" >> $HADOOP_BASH_IMPORT_PATH

source $HOME/.bashrc
