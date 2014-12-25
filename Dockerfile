FROM smalllark/java
MAINTAINER Dmitri Sh <smalllark@gmail.com>

# Install Upsource.
ENV UPSOURCE_VERSION 1.0.12551
RUN mkdir -p /usr/local/upsource
RUN apt-get update && \
    apt-get install -y unzip && \
    cd /usr/local/upsource && \
    wget -q http://download.jetbrains.com/upsource/upsource-$UPSOURCE_VERSION.zip && \
    unzip upsource-$UPSOURCE_VERSION.zip && \
    rm -rf upsource-$UPSOURCE_VERSION.zip
EXPOSE 8080
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
WORKDIR /usr/local/upsource/Upsource
CMD ["./bin/upsource.sh", "help", "start"]
