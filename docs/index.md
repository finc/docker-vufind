# Docker-VuFind

VuFind ausrollen - unabhängig von der Umgebung - auf Basis von Docker-Services.

---

## Überblick

Ziel dieses Projektes ist es, ein Set an Docker-Images zur Verfügung zu stellen, die
für Entwicklungs-, Test- und Produktivumgebungen geeignet ist. Alle Dienste, die von
VuFind benötigt werden, werden in eigenen Images gekapselt. Die Schnittstellen
wischen den Diensten beschränken sich auf Datei- und Netzwerk-Ebene.

### Produktionsumgebungen

Als Produktionsumgebungen bezeichne ich Umgebungen, in denen Nutzer einen Service
nutzen, bzw. reale Bedingungen abgebildet werden. Im üblichen Umgang sind dies Live-
und Staging-Umgebungen.

### Entwicklungsumgebungen

Als Entwicklungsumgebungen bezeichnet man Umgebungen, in denen Entwickler neue
Features entwicklen und testen. Hier werden weder echte Daten verarbeitet, noch echte
Informationen zurückgegeben. Im üblichen Umgang sind dies Alpha- und Dev-Umgebungen.

## Services

Folgende Services sind im Ökosystem VuFind beteiligt.

 * Applikationsserver [PHP]
 * Webserver [Apache2] oder [Nginx]
 * Datenbank-Server [MySQL] wird durch das offizielle Docker-Image bereitgestellt.

## VuFind

In diesem Stack nicht enthalten sind die Quellen von VuFind selbst. Diese müssen per
Volume-Bind zur Verfügung gestellt werden. Durch den [VuFind-Workflow] werden
ocker-Images erstelltn, die lediglich die VuFind-Sourcen inklusive
VuFind-Abhängigkeiten und kompilierte CSS-Dateien enthält. Die Dateien liegen im Image
unter `/usr/local/vufind`, sind jedoch noch unkonfiguriert.

## Todo

* Solr
* Entwicklerwerkzeuge
* Tests


[1]: https://store.docker.com/images/httpd
[2]: https://store.docker.com/images/nginx
[3]: https://ubleipzig.github.io/autoconfig/

[PHP]: services/php
[Apache2]: services/apache2
[Nginx]: services/nginx
[MySql]: https://store.docker.com/images/mysql
[VuFind-Workflow]: workflow/git
[docker-compose]: workflow/docker-compose