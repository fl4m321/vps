#!/bin/bash

# Create a directory for the project
mkdir -p my-gotty-project
cd my-gotty-project

# Create Dockerfile
cat <<EOF > Dockerfile
FROM ubuntu:14.04
LABEL maintainer="wingnut0310 <wingnut0310@gmail.com>"

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

# Install necessary dependencies
RUN apt-get -y update && \
    apt-get install -y python && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists*

# Expose the port that the service will run on
EXPOSE 8080

# Run a simple HTTP server on port 8080
CMD ["python", "-m", "SimpleHTTPServer", "8080"]
EOF

# Create docker-compose.yml
cat <<EOF > docker-compose.yml
version: '3.8'
services:
  my-gotty:
    hostname: mygotty
    ports:
      - "8989:8080"
    tty: true
    stdin_open: true
    image: my-gotty-image:latest
    build: .
EOF

# Create the run_gotty.sh (if needed for Gotty or future use)
cat <<EOF > run_gotty.sh
#!/bin/bash

# Start Gotty to serve bash over HTTP, but without write permissions
/usr/local/bin/gotty --permit-write=false --reconnect /bin/bash
EOF

# Make the run_gotty.sh file executable
chmod +x run_gotty.sh

# Build the Docker image
docker-compose build

# Start the container using docker-compose
docker-compose up -d

echo "Deployment is complete. Access your application at http://localhost:8989"
