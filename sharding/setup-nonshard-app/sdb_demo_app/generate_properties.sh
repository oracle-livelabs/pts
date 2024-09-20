ENDPOINT=`gdsctl status | grep Endpoint | sed -e 's/Endpoint summary *//'`
PASSW=app_schema

cat > $HOSTNAME.properties <<EOF
name=demo
endpoint=$ENDPOINT
catalog.dba.name=app_schema
catalog.dba.pass=$PASSW
app.service.write=oltp_rw.shpool.oradbcloud
app.service.readonly=oltp_rw.shpool.oradbcloud
app.user=app_schema
app.pass=$PASSW
EOF

