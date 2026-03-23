FROM tailscale/tailscale:stable AS tailscale

FROM node:20-bookworm-slim

WORKDIR /app

COPY --from=tailscale /usr/local/bin/tailscale /usr/local/bin/tailscale
COPY package.json server.js ./
COPY public ./public

ENV NODE_ENV=production
ENV HOST=0.0.0.0
ENV PORT=4180
ENV TAILSCALE_SOCKET=/var/run/tailscale/tailscaled.sock

EXPOSE 4180

CMD ["node", "server.js"]
