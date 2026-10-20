# Letta (Beyincik) Notları

**Serdar Kaptan**

```bash
docker run -d --name letta \
  -p 8283:8283 \
  -v letta_data:/var/lib/postgresql/data \
  -e OLLAMA_BASE_URL=http://host.docker.internal:11434/v1 \
  -e LETTA_MEMFS_SERVICE_URL=local \
  letta/letta:latest
```
