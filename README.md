[Upsource](https://www.jetbrains.com/upsource/) is a code review tool from [JetBrains](https://www.jetbrains.com/).

## How to use the image

If it is your initial Upsource run you have to configure it before use. This can be done by creating an intermediate container:

```
docker run --rm -v /data/upsource/conf:/opt/Upsource/conf klikatech/upsource \
  bin/upsource.sh configure --listen-port 8080
```

or if you're going to use a reverse proxy:

```
docker run --rm -v /data/upsource/conf:/opt/Upsource/conf klikatech/upsource \
  bin/upsource.sh configure --listen-port 8080 --base-url http://upsource.example.com
```

See [official docs](https://www.jetbrains.com/upsource/help/1.0/install_config.html) for details.

Now create some folders on host system to store application state:

```
mkdir -p /data/upsource/{data,logs,backups}
```

Also we need to set data ownership to upsource user (UID/GID=999):

```
chown -R 999:999 /data/upsource
```

Lastly, run a production container which will use previously persisted data:

```
docker run -d \
  -v /data/upsource/conf:/opt/Upsource/conf \
  -v /data/upsource/data:/opt/Upsource/data \
  -v /data/upsource/logs:/opt/Upsource/logs \
  -v /data/upsource/backups:/opt/Upsource/backups \
  -p 8080:8080 --name upsource klikatech/upsource
```
