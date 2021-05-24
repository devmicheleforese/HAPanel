# Influxdb

## Retention Policy

1. Connect to influx docker container
2. Connect to the database through:

   ```terminal
   influx
   ```

3. Authenticate

   ```terminal
   auth
   ```

4. Create Database

   ```terminal
   create database <database_name>

   ex:
   create database test_db
   ```

5. Use database

   ```terminal
   use <database_name>

   ex:
   use test_db
   ```

6. Create Retention policy for the hour

   ```terminal
   create retention policy <retention_policy_name> on <database_name> duration 1h replication 1 default

   ex:
   create retention policy rp_hour on test_db duration 1h replication 1 default
   ```

7. Create Retention policy for the day

   ```terminal
   create retention policy <retention_policy_name> on <database_name> duration 1d replication 1

   ex:
   create retention policy rp_day on test_db duration 1d replication 1
   ```

8. Create Retention policy for the month

   ```terminal
   create retention policy <retention_policy_name> on <database_name> duration 30d replication 1

   ex:
   create retention policy rp_month on test_db duration 30d replication 1
   ```

9. Show Retention Policy

   ```terminal
   show retention policy
   ```

## Continous Query

```terminal
CREATE CONTINUOUS QUERY "1h" ON "openhab3"
    BEGIN
        SELECT mean(value) AS VALUE INTO
        "day"."Gf_Kitchen_Sensor_Temperature"
        FROM "Gf_Kitchen_Sensor_Temperature"
        GROUP BY time(1h)
    END
```

```terminal
show continuous query
```

## Thing with Metadata for Aggregating data in Influxdb tables

1. Go to a thing and add a custom namespace `influxdb`

```terminal
value: <table_name>
config: {
  piano: "terra"
}
```

## Docker user

1. Create a user

```terminal
sudo useradd -rs /bin/false influxdb
sudo chown -r influxdb:influxdb .influxdb
```
