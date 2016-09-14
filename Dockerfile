### install debian ###
FROM docker.io/useltmann/dev-dotdeb:php54
MAINTAINER seltmann@ub.uni-leipzig.de
# install openjdk for solr
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-7-jdk

RUN echo "deb http://http.debian.net/debian wheezy-backports main" >/etc/apt/sources.list.d/wheezy-backports.list \
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs curl

EXPOSE 80 443 3306 8080
ENV APP_HOME=/usr/local/vufind2 \
 VUFIND_SOLR=local \
 VUFIND_HTTPD_CONF=local/httpd-vufind.conf

COPY assets/build /docker/build
RUN /docker/init \
 && rm -rf /docker/build

COPY assets/scripts /docker/scripts
COPY assets/setup /docker/setup

RUN chmod 755 /docker /docker/scripts/*
