### install debian ###
FROM smoebody/dev-dotdeb:latest
MAINTAINER seltmann@ub.uni-leipzig.de
EXPOSE 3306 80 443 8080
# install openjdk for solr
RUN apt-get update \
 && apt-get install -y openjdk-7-jdk
RUN rm -rf /docker/build
COPY assets/build /docker/build
RUN chmod 755 /docker/build/init \
 && /docker/build/init
COPY assets/setup /docker/setup
COPY assets/run /docker/run
RUN chmod 755 /docker/run/*
