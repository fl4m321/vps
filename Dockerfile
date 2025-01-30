# Use an official Ubuntu as the base image
FROM ubuntu:22.04

# Set environment variables for the terminal and Gotty
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV GOTTY_TAG_VER v1.0.1

# Install dependencies: curl, Docker, Gotty, and utilities
RUN apt-get update && \
    apt-get install -y \
    curl \
    sudo \
    docker.io \
    tar \
    wget \
    bash \
    && \
    curl -sLk https://github.com/yudai/gotty/releases/download/${GOTTY_TAG_VER}/gotty_linux_amd64.tar.gz \
    | tar xzC /usr/local/bin && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create the start script to run Gotty with a bash shell
RUN echo '#!/bin/bash' > /run_gotty.sh && \
    echo '/usr/local/bin/gotty --permit-write --reconnect --browser http://0.0.0.0:8080 /bin/bash' >> /run_gotty.sh && \
    chmod +x /run_gotty.sh

# Expose the port to access the Gotty terminal
EXPOSE 8080

# Set the command to start the Gotty web terminal on startup
CMD ["/bin/bash", "/run_gotty.sh"]
