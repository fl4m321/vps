# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Install necessary packages
RUN apt-get update && \
    apt-get install -y curl unzip sudo lsb-release gnupg2 ca-certificates software-properties-common && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Node.js (latest LTS)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

# Install Docker
RUN curl -fsSL https://get.docker.com | bash && \
    apt-get install -y docker-ce docker-ce-cli containerd.io && \
    apt-get clean

# Install Docker Compose (Optional, if you plan to use Compose)
RUN curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

# Create a new non-root user
RUN useradd -m coder && \
    mkdir -p /home/coder/.docker && \
    chown -R coder:coder /home/coder

# Switch to non-root user
USER coder
WORKDIR /home/coder

# Expose Docker socket to interact with Docker from within the container (optional)
VOLUME /var/run/docker.sock

# Set environment variables (optional)
ENV NODE_ENV=production

# Expose default ports for Node.js or any other service you might use
EXPOSE 8080

# Start a simple shell console (bash or zsh, for example)
CMD ["/bin/bash"]
