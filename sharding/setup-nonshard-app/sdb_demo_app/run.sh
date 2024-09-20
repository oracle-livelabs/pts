#!/bin/sh
PFILE=$2

if [ "x$PFILE" = "x" ]; then 
  PFILE=demo.properties
fi

mkdir -p log

CLASS_PATH=lib/ojdbc8.jar:lib/ucp.jar:build/demo.jar:lib/ons.jar
JAVAHOME=$ORACLE_HOME/jdk
$JAVAHOME/bin/java -cp $CLASS_PATH -Djava.util.logging.config.file=$1.logging.properties oracle.$1.Main $PFILE

