### httpd

*httpd* ist der Standard-Webserver, welcher Datei-Requests ausliefert und Anfragen an PHP an den
PHP-Service weiterleitet. Das Basis-Image ist [httpd:alpine][1].

Das Image wurde dahingehend erweitert, dass eine Standard-Konfiguration eingefügt wird, welche die
VuFind-spezifische Konfiguration beinhaltet. Die Konfiguration erwartet die Quellen von VuFind unter
`/usr/local/vufind`, die Cache-Dateien, welche von PHP/VuFind zur Laufzeit erzeugt werden, werden unter
`/var/cache/vufind` erwartet.

Weiterhin wurde ein eigener *entrypoint* erstellt, welcher den Pfadanteil der Request-URL anhand der Umgebungsvariablen `BASE_PATH` anpasst. Möchte man VuFind unter http://localhost/vufind aufrufen, muss
man bei Container-Start die Umgebungsvariable `BASE_PATH=/vufind` mitgeben.

    docker run \
      -v /path/to/vufind:/usr/local/vufind:ro \
      -v /path/to/cache:/var/cache/vufind:ro \
      -e BASE_PATH=/vufind \
      services.ub.uni-leipzig.de:10443/bdd_dev/vufind/httpd:latest

