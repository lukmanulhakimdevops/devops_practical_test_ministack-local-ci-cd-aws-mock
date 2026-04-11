# EC2 Mock Container - Simulasi VM yang menjalankan Docker
FROM alpine:latest

RUN apk add --no-cache docker openrc bash curl

# Setup Docker daemon (DinD)
RUN mkdir -p /etc/docker
RUN echo '{"hosts": ["unix:///var/run/docker.sock", "tcp://0.0.0.0:2375"]}' > /etc/docker/daemon.json

# Entrypoint script
COPY ec2-mock-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 2375 5000
ENTRYPOINT ["/entrypoint.sh"]
