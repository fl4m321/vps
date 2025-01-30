FROM ubuntu:14.04
LABEL maintainer="wingnut0310 <wingnut0310@gmail.com>"

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV GOTTY_TAG_VER v1.0.1

# Install necessary packages
RUN apt-get -y update && \
    apt-get install -y curl && \
    curl -sLk https://github.com/yudai/gotty/releases/download/${GOTTY_TAG_VER}/gotty_linux_amd64.tar.gz \
    | tar xzC /usr/local/bin && \
    apt-get purge --auto-remove -y curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists*

# Add run_gotty.sh script (which will launch the bash console)
COPY /run_gotty.sh /run_gotty.sh

# Make the script executable
RUN chmod +x /run_gotty.sh

# Expose port 8080 for Gotty
EXPOSE 8080

# Start Gotty with bash as the command
CMD ["/bin/bash", "/run_gotty.sh"]
