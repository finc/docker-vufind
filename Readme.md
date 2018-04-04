# Docker-VuFind

How VuFind can be deployed using Docker-Images, regardless of the environment.

---


Ziel dieses Projektes ist es, ein Set an Docker-Images zur Verfügung zu stellen, die für Entwicklungs-
Test- und Produktivumgebungen geeignet ist. Alle Dienste, die von VuFind benötigt werden, werden in
eigenen Images gekapselt. Die Schnittstellen zwischen den Diensten beschränken sich auf Datei- und
Netzwerk-Ebene.

## Services

Folgende Services sind im Ökosystem VuFind beteiligt. Nicht enthalten sind die Quellen von VuFind
selbst. Diese müssen per Volume-Bind zur Verfügung gestellt werden.

## Todo

* Solr
* Entwicklerwerkzeuge
* Tests


[1]: https://store.docker.com/images/httpd
[2]: https://store.docker.com/images/nginx
[3]: https://ubleipzig.github.io/autoconfig/