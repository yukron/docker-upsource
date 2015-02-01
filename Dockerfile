FROM java:openjdk-7-jre

MAINTAINER Eugene Volchek <evolchek@klika-tech.com>

ENV UPSOURCE_VERSION 1.0.12566
WORKDIR /opt
RUN groupadd -g 999 upsource && useradd -u 999 -g upsource upsource && \
	wget -nv http://download.jetbrains.com/upsource/upsource-$UPSOURCE_VERSION.zip && \
	unzip upsource-$UPSOURCE_VERSION.zip && \
	rm -rf upsource-$UPSOURCE_VERSION.zip && \
	rm -rf Upsource/conf && \
	mkdir -p Upsource/{data,backups,logs,conf} && \
	chown -R upsource:upsource Upsource/{data,backups,logs,conf}
USER upsource
EXPOSE 8080
WORKDIR /opt/Upsource
CMD ["bin/upsource.sh", "run"]
