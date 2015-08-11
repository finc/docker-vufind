### install debian ###
FROM smoebody/dev-dotdeb:latest
MAINTAINER seltmann@ub.uni-leipzig.de
EXPOSE 80 443 8080
# install openjdk for solr
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-7-jdk

RUN rm -rf /docker/build

COPY assets/build /docker/build
COPY assets/setup /docker/setup
COPY assets/scripts /docker/scripts

RUN chmod 755 /docker/build/init /docker/scripts/* \
 && /docker/build/init