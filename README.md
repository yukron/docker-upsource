[Upsource](https://www.jetbrains.com/upsource/) is a code review tool from [JetBrains](https://www.jetbrains.com/).

## How to use the image

It is recommended to use a data container to persist the application data:

```
docker run --name upsource-data \
  -v /opt/Upsource/conf \
  -v /opt/Upsource/data \
  -v /opt/Upsource/logs \
  -v /opt/Upsource/backups \
  busybox /bin/false
```

If it is your initial Upsource run you have to configure it before use. This can be done by creating an intermediate container:

```
docker run --rm --volumes-from upsource-data klikatech/upsource \
  bin/upsource.sh configure --listen-port 8080
```

or if you're going to use a reverse proxy:

```
docker run --rm --volumes-from upsource-data klikatech/upsource \
  bin/upsource.sh configure --listen-port 8080 --base-url http://upsource.example.com
```

See [official docs](https://www.jetbrains.com/upsource/help/1.0/install_config.html) for details.

Lastly, run a production container:

```
docker run -d --volumes-from upsource-data \
  -p 8080:8080 --name upsource klikatech/upsource
```
