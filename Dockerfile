FROM ubuntu:14.04
LABEL maintainer="wingnut0310 <wingnut0310@gmail.com>"

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

# Install necessary dependencies
RUN apt-get -y update && \
    apt-get install -y python curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists*

# Create a directory for the project
RUN mkdir -p /my-gotty-project
WORKDIR /my-gotty-project

# Expose the port that the service will run on
EXPOSE 8080

# Run a simple HTTP server on port 8080
CMD ["python", "-m", "SimpleHTTPServer", "8080"]
