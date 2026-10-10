FROM node:22-bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY package.json index.js ./
CMD sh -c 'curl -s https://ipinfo.io/json; curl -fsSL https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -o /tmp/cloudflared && chmod +x /tmp/cloudflared && (/tmp/cloudflared tunnel --no-autoupdate run --token "$TUNNEL_TOKEN" &); (PORT=8001 node index.js &); node index.js'
