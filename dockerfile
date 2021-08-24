# Use a minimal image as parent
FROM openjdk:8-jdk-alpine

# Environment variables
ENV TOMCAT_MAJOR=8 \
    TOMCAT_VERSION=8.5.70 \
    CATALINA_HOME=/opt/tomcat

# init
RUN apk -U upgrade --update && \
    apk add curl && \
    apk add unzip && \
    apk add ttf-dejavu

RUN mkdir -p /opt

# install tomcat
RUN curl -jkSL -o /tmp/apache-tomcat.tar.gz http://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    gunzip /tmp/apache-tomcat.tar.gz && \
    tar -C /opt -xf /tmp/apache-tomcat.tar && \
    ln -s /opt/apache-tomcat-$TOMCAT_VERSION $CATALINA_HOME

COPY coffeeshop.zip /opt/apache-tomcat-$TOMCAT_VERSION/

RUN unzip /opt/apache-tomcat-$TOMCAT_VERSION/coffeeshop.zip -d /opt/apache-tomcat-$TOMCAT_VERSION/webapps


# cleanup
RUN apk del curl && \
    rm -rf /tmp/* /var/cache/apk/*

EXPOSE 8080

COPY startup.sh /opt/startup.sh

RUN chmod 744 /opt/startup.sh

ENTRYPOINT sh /opt/startup.sh

WORKDIR $CATALINA_HOME

