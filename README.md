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

### Verification

#### 1. Name Node setup

```
$ cd ~
$ hdfs namenode -format
```

#### 2. Hadoop dfs

If ssh is refusing connection, try `sudo apt-get install openssh-server`. Then, type:

```
$ start-dfs.sh
```

#### 3. Yarn script

```
$ start-yarn.sh
```

#### 4. Accessing Hadoop on browser

```
http://localhost:50070/
```

#### 5. Verify all applications for cluster

```
http://localhost:8088/
```
