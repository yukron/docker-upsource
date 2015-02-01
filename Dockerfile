FROM java:openjdk-7-jre
MAINTAINER Eugene Volchek <evolchek@klika-tech.com>

# Install Upsource.
ENV INSTALL_TO /opt
ENV UPSOURCE_VERSION 1.0.12566
ADD http://download.jetbrains.com/upsource/upsource-$UPSOURCE_VERSION.zip /tmp/
RUN mkdir -p $INSTALL_TO && \
    cd $INSTALL_TO && \
    unzip /tmp/upsource-$UPSOURCE_VERSION.zip && \
    rm -rf /tmp/upsource-$UPSOURCE_VERSION.zip && \
    rm -rf $INSTALL_TO/Upsource/conf && \
    mkdir -p $INSTALL_TO/Upsource/{data,backups,logs,conf}
# Clean up APT when done.
RUN useradd -r upsource
RUN chown -R upsource:upsource $INSTALL_TO/Upsource
USER upsource
EXPOSE 8080
WORKDIR $INSTALL_TO/Upsource
ENTRYPOINT ["bin/upsource.sh"]
CMD ["run"]
