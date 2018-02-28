* based on php:php:5-fpm
* adds one volume:
 * "/var/vache/vufind"
* adds new entrypoint
 * copies sql-initfiles to separate folders so they can be mapped to mariadb/mysql/postgresql docker-images
 * chowns all files in /usr/local/vufind and /var/cache/vufind
 * executes original php-entrypoint with all params
* creates folders /init-db/{mysql,psql} to make them available to the entrypoint-script for copying the sql-initfiles
* installs dependencies for all needed php-modules
* sets default environment variables needed for vufind
* downloads vufind and extracts it to /usr/local/vufind
* sets the default command to 'php-fpm'