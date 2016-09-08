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
$ ./install_pseudo_distributed_mode.sh

### Running

```
$ ./examples_pseudo_distributed_mode.sh
