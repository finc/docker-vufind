### php

*php* ist der Applicationserver, welcher die Programmlogik von VuFind abarbeitet. Anfragen werden
vom Webserver an *php* weitergeleitet, verarbeitet und an den Webserver zur Auslieferung zurückgegeben.

Das Image basiert auf der FPM-Variante des offiziellen PHP-Images, jeweils in den Tags `5` und `7`,
wobei `5` auch `latest` ist. Außerdem kommen beide Images in einer Debug-Variante mit dem Suffix
`-debug`, siehe [debug](#debug)

Die Konfiguration von VuFind erfolgt über Umgebungsvariablen, welche dem Container bei der
Erstellung mitgegeben werden können.

* `VUFIND_CACHE_DIR=/var/cache/vufind`: spezifiziert den Cache-Ordner, welcher genutzt wird, um
den VuFind-Cache abzulegen. Der Ordner wird bei Container-Start erstellt, wenn nicht vorhanden.
* `VUFIND_APPLICATION_PATH=/usr/local/vufind`: spezifiziert den Ordner, in dem sich der VuFind-Programmcdoe befindet. Der Ordner muss zu Container-Start vorhanden sein, also via Bind-Mount eingebunden werden, da er **nicht** im Image vorhanden ist.
* `VUFIND_LOCAL_DIR=/usr/local/vufind/local`: spezifiziert den Ordner, der die Konfigurationsdateien
von VuFind beinhaltet. Dieser Ordner muss zu Container-Start ebenfalls exisiteren.

folgende php-Erweiterungen sind im Image einkompiliert:

* mysqli
* pdo_pgsql
* pdo_mysql
* gd
* xsl
* mcrypt
* intl
* soap
* xdebug (nur `-debug`-Variante)

Der Start des Containers erfolgt so:

    docker run \
      -v /path/to/vufind:/usr/local/vufind \
      -v /path/to/cache:/var/cache/vufind \
      -e VUFIND_LOCAL_DIR=/usr/local/vufind/local/staging
      services.ub.uni-leipzig.de:10443/bdd_dev/vufind/php:5

#### Debug

In der Debug-Variante der Images ist zusätzlich die PHP-Erweiterung *xdebug* installiert und konfiguriert, dass es automatisch startet.

Weiterhin werden alle Dateien und Ordner, die von PHP erstellt werden, mit der Besitzer- und
Gruppenzugehörigkeit des Entwicklers erstellt. Somit kann dieser ohne weitere Berechtigungen diese
Dateien und Ordner ändern, bzw. löschen.

    docker run \
      -v /path/to/vufind:/usr/local/vufind \
      -v /path/to/cache:/var/cache/vufind \
      -e VUFIND_LOCAL_DIR=/usr/local/vufind/local/dev \
      services.ub.uni-leipzig.de:10443/bdd_dev/vufind/php:5-debug


#### phing

Mit der Abhängigkeitsauflösung von VuFind mittels `composer` kommen noch weitere Entwicklerwerkzeuge,
wie

* phpcs
* php-cs-fixer
* phpunit
* phpdoc
* phpcpd
* phpmd
* pdepend
* phploc

*phing* wird genutzt, um die Standard-VuFind Tasks aufzurufen, z.B.:

    docker run --rm -ti \
      -v /path/to/vufind:/usr/local/vufind \
      services.ub.uni-leipzig.de:10443/bdd_dev/vufind/util:latest \
      phing composer

um PHP-Abhängigkeiten zu installieren.

    docker run --rm -ti \
      -v /path/to/vufind:/usr/local/vufind \
      services.ub.uni-leipzig.de:10443/bdd_dev/vufind/util:latest \
      phing phpunit

um PHPUnit-Tests abzuarbeiten

    docker run --rm -ti \
      -v /path/to/vufind:/usr/local/vufind \
      services.ub.uni-leipzig.de:10443/bdd_dev/vufind/util:latest \
      phing phpcs-console

um den PHP-Code-Sniffer auszuführen

#### autoconfig

*autoconfig* erstellt aus Umgebungsvariablen und/oder commandline-options eine funktionstüchtige
VuFind-Konfiguration, basierend auf einer Standardkonfiguration. Die erstellte Konfiguration erbt
von der Standardkonfiguration und überschreibt individuelle Einstellungen.

    docker run --rm -ti \
      -v /path/to/vufind:/usr/local/vufind \
      -e VUFIND_SITE=local \
      -e VUFIND_INSTANCE=staging \
      -e VF_config_ini__Database__database=mysql://vufind:vufindpw@db/vufind \
      -e VF_config_ini__Authentication__hash_passwords=true \
      -e VF_config_ini__Authentication__encrypt_ils_password=true \
      services.ub.uni-leipzig.de:10443/bdd_dev/vufind/util:latest \
      autoconfig vufind deploy

Dieser Befehl erstellt eine neue Konfiguration unter `/usr/local/vufind/local/staging`, welche von
der Standardkonfiguration unter `/usr/local/vufind/local` ableitet und Einstellungen

    [Database]
    database = mysql://vufind:vufindpw@db/vufind

    [Authentication]
    hash_passwords = true
    encrypt_ils_password = true

in der Datei `config.ini` setzt.

Weiterhin wird Anhand der Datenbank-Konfiguration eine Datenbank auf dem Datenbank-Server erstellt,
sofern nicht vorhanden und zugreifbar.

Weitere Informationen findet sich in der [Dokumentation zu *autoconfig*][3]
