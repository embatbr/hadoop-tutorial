# hadoop-tutorial

Following the tutorial from [tutorialspoint](http://www.tutorialspoint.com/hadoop/).


## Pre-installation

If Java is not set, add the following lines to `$HOME/.bashrc`:

```bash
export JAVA_HOME=/usr/lib/jvm/java-7-oracle
export PATH=$PATH:$JAVA_HOME/bin
```

Add the line

```bash
source $HOME/apps/hadoop/bashrc_import.sh
```

to *~/.bashrc* but don't "source" it yet. The installation script will create this file.


## Standalone mode

### Installing

```
$ ./install_standalone_mode.sh
```

### Running

```
$ ./examples_standalone_mode.sh
```


## Pseudo-distributed mode

### Installing

```
$ ./install_pseudodistributed_mode.sh
```

**OBS: edit lines below**

#### Configuration

Go to directory **$HADOOP_HOME/etc/hadoop**. In the file **hadoop-env.sh**, replace

```
export JAVA_HOME=${JAVA_HOME}
```

by

```
export JAVA_HOME="/usr/lib/jvm/java-7-oracle"
```

Still in this directory, replace any content from the following files with the ones presented.

##### core-site.xml

```
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>


<configuration>
    <property>
        <name>fs.default.name</name>
        <value>hdfs://localhost:9000/home/embat/tmp/hadoop/storage</value>
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
        <value>file:///home/embat/tmp/hadoop/infra/hdfs/namenode</value>
    </property>
    <property>
        <name>dfs.data.dir</name>
        <value>file:///home/embat/tmp/hadoop/infra/hdfs/datanode</value>
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

##### 1. Name Node setup

```
$ cd ~
$ hdfs namenode -format
```

##### 2. Hadoop dfs

If ssh is refusing connection, try `sudo apt-get install openssh-server`. Then, type:

```
$ start-dfs.sh
```

##### 3. Yarn script

```
$ start-yarn.sh
```

##### 4. Accessing Hadoop on browser

```
http://localhost:50070/
```

##### 5. Verify all applications for cluster

```
http://localhost:8088/
```
