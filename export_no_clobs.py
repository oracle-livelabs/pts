"""Export without CLOB columns - clean CSV"""
import getpass
import sys
import time
import oracledb

ADB_SJ_DSN = (
    "(description=(retry_count=20)(retry_delay=3)"
    "(address=(protocol=tcps)(port=1522)"
    "(host=adb.us-sanjose-1.oraclecloud.com))"
    "(connect_data=(service_name=fp7cb75hkszpygo_adbsj_high.adb.oraclecloud.com))"
    "(security=(ssl_server_dn_match=yes)"
    "(my_wallet_directory=C:\\Users\\Blake\\Downloads\\Wallet_ADBSJ)))"
)

FILE_URI = (
    "https://objectstorage.us-sanjose-1.oraclecloud.com/p/WJ9GXh4EWOuj5myI-HjzufYbg7H9yu0tnzzLBpsXeXp7u_PsyYzydvE17NttDdlp/"
    "n/oraclepartnersas/b/adb_migration_bucket/o/customer_orders_clean.csv"
)

password = getpass.getpass("Enter password for adb_sanjose: ")

try:
    with oracledb.connect(user="ADMIN", password=password, dsn=ADB_SJ_DSN) as conn:
        with conn.cursor() as cur:
            cur.execute("SELECT COUNT(*) FROM customer_orders_demo")
            count = cur.fetchone()[0]
            print(f"Source table has {count} rows")
            
            print("\nExporting WITHOUT CLOB columns (clean CSV)...")
            cur.execute(f"""
                BEGIN
                  DBMS_CLOUD.EXPORT_DATA(
                    file_uri_list => '{FILE_URI}',
                    query => 'SELECT 
                        order_id, customer_id, customer_name, customer_email,
                        order_status, order_channel, order_date, order_ts,
                        shipping_city, shipping_state, shipping_postal, shipping_country,
                        shipping_status, order_total, discount_percent, tax_amount,
                        currency_code, payment_method, payment_auth_code,
                        is_fraud_suspected, created_at, updated_at
                      FROM customer_orders_demo',
                    format => json_object('type' VALUE 'csv', 'delimiter' VALUE ',')
                  );
                END;
            """)
            
            print("✓ Export completed! Clean CSV without CLOBs created.")
            print(f"File: customer_orders_clean*.csv")

except Exception as e:
    print(f"❌ ERROR: {e}")
    sys.exit(1)