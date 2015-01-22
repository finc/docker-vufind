### install debian ###
FROM debian:latest
MAINTAINER seltmann@ub.uni-leipzig.de
EXPOSE 3306 80 443 8080
VOLUME ["/var/lib/mysql", "/var/run/mysqld", "/usr/local/vufind2", "/var/lib/xdebug"]
ENTRYPOINT ["/app/init"]
CMD ["run"]
ENV DEBIAN_FRONTEND noninteractive
# adding dot-deb repository
RUN apt-get update \
 && apt-get -y dist-upgrade \
 && apt-get install -y wget \
 && echo "deb http://packages.dotdeb.org wheezy all" >/etc/apt/sources.list.d/dotdeb.list \
 && wget -O - http://www.dotdeb.org/dotdeb.gpg | apt-key add - \
 && apt-get update \
 && apt-get install -y less vim supervisor openssl ca-certificates apache2-mpm-worker apache2-suexec libapache2-mod-fcgid \
        php5-cgi php5-cli php-pear php5-curl php5-gd php5-intl php5-ldap php5-mcrypt php5-mysqlnd php5-readline php5-sqlite php5-xcache php5-xdebug php5-xsl php5-dev \
        make mysql-client mysql-server openjdk-7-jdk unzip
COPY assets/build /app/build
RUN chmod 755 /app/build/init \
 && /app/build/init

COPY assets/setup /app/setup
COPY assets/run /app/run
COPY assets/init /app/init
RUN chmod 755 /app/init /app/run/*