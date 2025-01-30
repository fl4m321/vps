# Use an Ubuntu image as the base
FROM ubuntu:22.04

# Set environment variables
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV GOTTY_TAG_VER v1.0.1

# Install dependencies: curl, Docker, and Gotty
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

# Create a script to start Gotty with the bash shell
COPY run_gotty.sh /run_gotty.sh

# Make the script executable
RUN chmod +x /run_gotty.sh

# Expose the port for Gotty (web console)
EXPOSE 8080

# Start Gotty with root access
CMD ["/bin/bash", "/run_gotty.sh"]
