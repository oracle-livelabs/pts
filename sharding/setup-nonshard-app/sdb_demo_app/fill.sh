#!/bin/sh
PFILE=$1

if [ "x$PFILE" = "x" ]; then 
  PFILE=demo.properties
fi

$ORACLE_HOME/jdk/bin/java -cp `cat .classpath` -Djava.util.logging.config.file=demo.logging.properties oracle.demo.FillProducts $PFILE

ADDR=`gdsctl status | grep Endpoint | sed -e 's/Endpoint summary          //'`

for instance in `gdsctl status database | grep '\w\+%[0-9]\+'`; do 
CSTR="(description=$ADDR(connect_data=(service_name=oltp_rw_srvc.orasdb.oradbcloud)(instance_name=$instance)))";
echo -e "exec DBMS_MVIEW.REFRESH('PRODUCTS');\n" | sqlplus -S app_schema/app_schema@$CSTR >> log/refresh.log
done

