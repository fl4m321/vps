FROM ubuntu:14.04
LABEL maintainer="wingnut0310 <wingnut0310@gmail.com>"

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

RUN apt-get -y update && \
    apt-get install -y python && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists*

# Copy any necessary files for your web server (e.g., HTML or assets)
# COPY ./my-site /usr/share/nginx/html

EXPOSE 8080

# Run a simple HTTP server on port 8080 (non-interactive)
CMD ["python", "-m", "SimpleHTTPServer", "8080"]
