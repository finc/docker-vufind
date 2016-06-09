### install debian ###
FROM docker.io/smoebody/dev-dotdeb:latest
MAINTAINER seltmann@ub.uni-leipzig.de
# install openjdk for solr
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-7-jdk

RUN echo "deb http://http.debian.net/debian jessie-backports main" >/etc/apt/sources.list.d/jessie-backports.list \
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs curl

EXPOSE 80 443 3306 8080
ENV APP_HOME /usr/local/vufind2
VOLUME ["/var/lib/mysql", "/var/run/mysqld", "${APP_HOME}", "/var/lib/xdebug"]

RUN rm -rf /docker/build

COPY assets/build /docker/build
RUN chmod 755 /docker/build/init \
 && /docker/build/init

COPY assets/scripts /docker/scripts
RUN chmod 755 /docker/scripts/* 

COPY assets/setup /docker/setup
