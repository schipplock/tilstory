FROM maven:3.9.6-eclipse-temurin-21-jammy AS build-war
SHELL ["/bin/bash", "-c"]

COPY ./ /src
RUN cd /src && mvn clean package

FROM ubuntu:22.04 AS base
SHELL ["/bin/bash", "-c"]

ENV WILDFLY_VERSION=31.0.1.Final
ENV JBOSS_HOME=/opt/jboss/wildfly
ENV LAUNCH_JBOSS_IN_BACKGROUND=true
ENV LANG=de_DE.utf8
ENV TZ=Europe/Berlin
ENV DEBIAN_FRONTEND=noninteractive
ENV JAVA_HOME=/opt/java
ENV UPLOAD_DIR=$JBOSS_HOME/uploads
ENV REMOTE_DEBUG_ENABLED=false
ENV PATH=/opt/java/bin:/opt/tomcat/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN apt-get update && apt-get install -y \
  wget locales tzdata

RUN mkdir -p /opt/java \
 && wget --no-check-certificate "https://download.bell-sw.com/java/21.0.1+12/bellsoft-jre21.0.1+12-linux-amd64.tar.gz" \
 && tar xf bellsoft-jre21.0.1+12-linux-amd64.tar.gz -C /opt/java --strip-components=1 \
 && rm -rf /opt/java/{man,legal} \
 && rm bellsoft-jre21.0.1+12-linux-amd64.tar.gz \
 && cd $HOME \
 && mkdir -p $JBOSS_HOME && mkdir -p $JBOSS_HOME/uploads \
 && wget --no-check-certificate https://github.com/wildfly/wildfly/releases/download/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz \
 && tar xf wildfly-$WILDFLY_VERSION.tar.gz -C $JBOSS_HOME --strip-components=1 \
 && rm wildfly-$WILDFLY_VERSION.tar.gz \
 && rm -rf $JBOSS_HOME/docs \
 && locale-gen ${LANG} \
 && update-locale LANG=${LANG} \
 && cp -vf /usr/share/zoneinfo/${TZ} /etc/localtime \
 && echo ${TZ} | tee /etc/timezone \
 && dpkg-reconfigure --frontend noninteractive tzdata \
 && addgroup --gid 1000 jboss \
 && adduser --system --uid 1000 --no-create-home --shell /bin/bash --home "/opt/jboss" --gecos "" --ingroup jboss jboss \
 && echo jboss:jboss | chpasswd \
 && chown -R jboss:0 ${JBOSS_HOME} \
 && chmod -R g+rw ${JBOSS_HOME}

FROM base

COPY docker/entrypoint.sh /bin/entrypoint.sh
COPY docker/postgresql-42.7.1.jar $JBOSS_HOME/standalone/deployments/postgresql-driver.jar
COPY --from=build-war /src/target/tilstory-0.0.11.war $JBOSS_HOME/standalone/deployments/tilstory.war
COPY docker/standalone.xml $JBOSS_HOME/standalone/configuration/standalone.xml
COPY docker/application.keystore $JBOSS_HOME/standalone/configuration/application.keystore

RUN chmod +x /bin/entrypoint.sh

USER jboss
WORKDIR /opt/jboss
EXPOSE 8080
CMD ["/bin/entrypoint.sh"]