FROM java:openjdk-7-jre
MAINTAINER Eugene Volchek <evolchek@klika-tech.com>

# Install Upsource.
ENV INSTALL_TO /opt
ENV UPSOURCE_VERSION 1.0.12566
ADD http://download.jetbrains.com/upsource/upsource-$UPSOURCE_VERSION.zip /tmp/
RUN mkdir -p $INSTALL_TO && \
    apt-get update && \
    apt-get install -y unzip && \
    cd $INSTALL_TO && \
    unzip /tmp/upsource-$UPSOURCE_VERSION.zip && \
    rm -rf /tmp/upsource-$UPSOURCE_VERSION.zip && \
    rm -rf $INSTALL_TO/Upsource/conf && \
    mkdir -p $INSTALL_TO/Upsource/{data,backups,logs,conf}
EXPOSE 8080
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
WORKDIR $INSTALL_TO/Upsource
CMD ["./bin/upsource.sh", "start"]
