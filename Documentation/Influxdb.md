# Influxdb

## Create Influx database

1. Retrive docker container ID trough

   ```terminal
   docker container ls
   ```

2. Exec bash commands in docker container

   ```terminal
   docker exec -it <docker container ID> /bin/bash
   ```

3. Enter in influx database

   ```temrminal
   influx
   ```

4. Create the Databse

   ```terminal
   create database openhab3
   ```

   - To verify:

   ```terminal
   show databases;
   ```

5. Open Database

   ```terminal
   use openhab3
   ```

6. Create Admin User

   ```terminal
   create user admin with password 'openhab' with all privileges
   ```

7. Create influxdb config file

   ```terminal
   influxd config > /var/lib/influxdb/influxdb.conf
   ```

8. Change config file

   ```terminal
   nano influxdb.conf
   ```

   Change this line

   ```terminal
   [http]
      auth-enabled = true
   ```

9. Authenticate

   ```terminal
   influxdb
   auth
   ```

   - username: admin
   - password: admin #IDK

10. Change openHAB credentials for DB

    ```terminal
    sudo nano influxdb.cfg
    ```

11. Create `openhab` user in influxdb

    ```terminal
    create user openhab with password 'openhab`
    ```

## To check if influxdb is active

1. Access with `openhab` user

   ```terminal
   influx
   auth
      username: openhab
      password: openhab
   ```

2. Check data

```terminal
use openhab3
show measurements
precision rfc3339
select * from <table> order by time DeSC limit
```

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
