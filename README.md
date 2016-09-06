# hadoop-tutorial

Following the tutorial from [tutorialspoint](http://www.tutorialspoint.com/hadoop/).


## Enviornment Setup

Create an user named **hadoop**, with password **hadoop**.

```
$ sudo su
# adduser hadoop
```

### Create user `hadoop`

If it doesn't exist, create a RSA key to SSH:

```
$ ssh-keygen -t rsa
$ cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
$ chmod 0600 ~/.ssh/authorized_keys
```

### Setting Java

Add the following to `~/.bashrc`:

```
export JAVA_HOME=/usr/lib/jvm/java-7-oracle
export PATH=$PATH:$JAVA_HOME/bin
```

### Download Hadoop

Download the newest version of Hadoop (in this case `2.7.3`):

```
$ cd ~/data/programs
$ wget http://mirror.nbtelecom.com.br/apache/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz
$ tar xzf hadoop-2.7.3.tar.gz
```

### Install in local/standalone mode

Add the following lines to **~/.bashrc**:

```
export HADOOP_HOME="~/data/programs/hadoop-2.7.3"
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
```

and check if Hadoop is installed typing `hadoop version`. There's no daemons running and everything executes in a single JVM. Create an input directory in any place and fill it with mock text files:

```
$ mkdir input
$ cp $HADOOP_HOME/*.txt input
```

Test the example **WordCount** running the script **run_examples.sh**.

### Install in pseudo distributed mode

In **~/.bashrc**, replace

```
export HADOOP_HOME="~/data/programs/hadoop-2.7.3"
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
```

by

```
hadoop_installation_mode="pseudo-distributed"
export HADOOP_HOME="$HOME/data/programs/hadoop-2.7.3"

if [ "$hadoop_installation_mode" == "pseudo-distributed" ]; then
    export HADOOP_MAPRED_HOME=$HADOOP_HOME
    export HADOOP_COMMON_HOME=$HADOOP_HOME
    export HADOOP_HDFS_HOME=$HADOOP_HOME
    export YARN_HOME=$HADOOP_HOME
    export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
    export HADOOP_INSTALL=$HADOOP_HOME
    export HADOOP_OPTS="$HADOOP_OPTS -Djava.library.path=$HADOOP_COMMON_LIB_NATIVE_DIR"
fi

export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
```

#### Configuration

In file **$HADOOP_HOME/etc/hadoop/hadoop-env.sh**, replace

```
export JAVA_HOME=${JAVA_HOME}
```

by

```
export JAVA_HOME="/usr/lib/jvm/java-7-oracle"
```

##### core-site.xml

```
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>


<configuration>
    <property>
        <name>fs.default.name</name>
        <value>hdfs://localhost:9000</value>
   </property>
</configuration>
```

##### hdfs-site.xml

```
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>


<configuration>
    <property>
        <name>dfs.replication</name>
        <value>1</value>
    </property>
    <property>
        <name>dfs.name.dir</name>
        <value>file:///home/embat/hadoop/hadoopinfra/hdfs/namenode </value>
    </property>
    <property>
        <name>dfs.data.dir</name>
        <value>file:///home/embat/hadoop/hadoopinfra/hdfs/datanode </value>
    </property>
</configuration>
```

##### yarn-site.xml

```
<?xml version="1.0"?>


<configuration>
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>
</configuration>
```

##### mapred-site.xml

```
<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>


<configuration>
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
</configuration>
```

#### Verification

##### Name Node setup

```
$ cd ~
$ hdfs namenode -format
```

##### Verifying Hadoop dfs

If ssh is refusing connection, try `sudo apt-get install openssh-server`. Then, type:

```
$ start-dfs.sh
```

##### Verifying Yarn script

```
$ start-yarn.sh
```

##### Accessing Hadoop on browser

```
http://localhost:50070/
```

##### Verify all applications for cluster

```
http://localhost:8088/
```
