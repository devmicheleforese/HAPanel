# Docker image

```terminal
docker build -t acmesystems/openhab_mosquitto:1 -f docker/dockerfile.mosquitto .

docker push acmesystems/openhab_mosquitto:1
```

```terminal
docker build -t acmesystems/openhab_influxdb:1 -f docker/dockerfile.influxdb .

docker push acmesystems/openhab_influxdb:1
```

```terminal
docker build -t acmesystems/openhab_grafana:1 -f docker/dockerfile.grafana .

docker push acmesystems/openhab_grafana:1
```

```terminal
docker build -t acmesystems/openhab_openhab:1 -f docker/dockerfile.openhab .

docker push acmesystems/openhab_openhab:1
```

```terminal
docker build -t acmesystems/openhab_tasmoadmin:1 -f docker/dockerfile.tasmoadmin .

docker push acmesystems/openhab_tasmoadmin:1
```
