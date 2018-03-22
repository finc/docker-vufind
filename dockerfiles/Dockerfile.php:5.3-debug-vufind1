FROM cespi/php-5.3:fpm
ENTRYPOINT [ "/docker-entrypoint" ]

ENV VUFIND_CACHE_DIR=/var/cache/vufind \
  VUFIND_APPLICATION_PATH=/usr/local/vufind

COPY assets/entrypoint-php-debug /docker-entrypoint

RUN apk add --no-cache --update icu-dev freetype-dev libjpeg-turbo-dev libmcrypt-dev libpng-dev libxslt-dev postgresql-dev zlib-dev bzip2-dev autoconf mariadb-dev \
  && apk add libpng libjpeg-turbo freetype icu-libs libpq libmcrypt libxslt mariadb-client-libs python make g++ coreutils nodejs git subversion mariadb-client openssh openssl bash \
  && docker-php-ext-configure gd --with-freetype-dir=/usr/include --with-jpeg-dir=/usr/include \
  && docker-php-ext-install -j$(nproc) mysql gd xsl mcrypt intl zip bz2 \
  && pecl install xdebug-2.2.7 \
  && docker-php-ext-enable xdebug \
  && apk del icu-dev freetype-dev libjpeg-turbo-dev libmcrypt-dev libpng-dev libxslt-dev postgresql-dev zlib-dev bzip2-dev autoconf  mariadb-dev \
  && sed -i '1 a xdebug.remote_autostart=true' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
  && sed -i '1 a xdebug.remote_mode=req' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
  && sed -i '1 a xdebug.remote_handler=dbgp' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
  && sed -i '1 a xdebug.remote_connect_back=1 ' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
  && sed -i '1 a xdebug.remote_port=9000' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
  && sed -i '1 a xdebug.remote_enable=1' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
  && echo 'security.limit_extensions = .php .css' >> /usr/local/etc/php-fpm.d/www.conf \
  && echo 'php_admin_value[magic_quotes_gpc] = false' >> /usr/local/etc/php-fpm.d/www.conf \
  && echo 'php_admin_value[session.use_cookies] = 1' >> /usr/local/etc/php-fpm.d/www.conf \
  && echo 'php_admin_value[session.use_only_cookies] = 1' >> /usr/local/etc/php-fpm.d/www.conf \
  && echo 'php_admin_value[session.auto_start] = 0' >> /usr/local/etc/php-fpm.d/www.conf \
  && echo 'php_admin_value[session.cookie_lifetime] = 0' >> /usr/local/etc/php-fpm.d/www.conf \
  && echo 'php_admin_value[session.gc_maxlifetime] = 6000' >> /usr/local/etc/php-fpm.d/www.conf \
  && echo 'php_admin_value[display_errors] = 0' >> /usr/local/etc/php-fpm.d/www.conf \
  && echo 'php_admin_value[log_errors] = 1' >> /usr/local/etc/php-fpm.d/www.conf \
  && echo 'php_admin_value[error_reporting] = 2047' >> /usr/local/etc/php-fpm.d/www.conf \
  && wget -O - https://github.com/smarty-php/smarty/archive/v2.6.26.tar.gz | tar -C /tmp/ -zxvf - smarty-2.6.26/libs \
  && mv /tmp/smarty-2.6.26/libs /usr/local/lib/php/Smarty \
  && rm /tmp/* -rf \
  && pear channel-discover pear.phing.info \
  && pear install --onlyreqdeps phing/phing \
  && pear install --onlyreqdeps DB-1.9.0 \
  && pear install --onlyreqdeps DB_DataObject-1.11.3 \
  && pear install --onlyreqdeps Structures_DataGrid-beta \
  && pear install --onlyreqdeps Structures_DataGrid_DataSource_DataObject-beta \
  && pear install --onlyreqdeps Structures_DataGrid_DataSource_Array-beta \
  && pear install --onlyreqdeps Structures_DataGrid_Renderer_HTMLTable-beta \
  && pear install --onlyreqdeps HTTP_Client \
  && pear install --onlyreqdeps Log \
  && pear install --onlyreqdeps Mail \
  && pear install --onlyreqdeps Mail_Mime \
  && pear install --onlyreqdeps Net_SMTP \
  && pear install --onlyreqdeps XML_Serializer-beta \
  && pear install --onlyreqdeps Console_ProgressBar-beta \
  && pear install --onlyreqdeps File_Marc-alpha \
  && pear channel-discover pear.horde.org \
  && pear channel-update pear.horde.org \
  && pear install Horde/Horde_Yaml-beta \
  && pear install --onlyreqdeps Config_Lite-0.2.6 \
  && chmod a+x /docker-entrypoint

WORKDIR ${VUFIND_APPLICATION_PATH}

CMD [ "php-fpm" ]