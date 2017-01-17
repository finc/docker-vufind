### install debian ###
FROM docker.io/useltmann/dev-dotdeb:php_5.6-2
MAINTAINER seltmann@ub.uni-leipzig.de
# install openjdk for solr, nodejs for grunt
RUN wget -qO- https://deb.nodesource.com/setup_7.x | bash - \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs curl openjdk-7-jdk \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /var/cache/apt/archives/*

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
