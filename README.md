
## Das Image bauen

```bash
docker build --no-cache --network=host --force-rm -t local/tilstory-app:latest .
```

```bash
docker build --network=host --force-rm -t local/tilstory-wildfly:30.0.1 .
```