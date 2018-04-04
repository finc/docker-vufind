### nginx

*nginx* steht als alternativer Webserver zur Verfügung und kann statt *httpd* verwendet werden.
Das Basis-Image ist [nginx:alpine][2]

Ebenso wie beim *httpd*-Image werden VuFind-Dateien erwartet und der `BASE_PATH` zum Konfigurieren
des Pfad-Anteils gesetzt

    docker run \
      -v /path/to/vufind:/usr/local/vufind:ro \
      -v /path/to/cache:/var/cache/vufind:ro \
      -e BASE_PATH=/vufind \
      services.ub.uni-leipzig.de:10443/bdd_dev/vufind/nginx:latest

