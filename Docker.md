# vufind2

## What is Vufind?

from [https://vufind-org.github.io/vufind/][1]

> VuFind is a library resource portal designed and developed for libraries by libraries. The goal of VuFind is to enable your users to search and browse through all of your library's resources by replacing the traditional OPAC to include:

> * _Catalog Records_
* _Locally Cached Journals_
* _Digital Library Items_
* _Institutional Repository_
* _Institutional Bibliography_
* _Other Library Collections and Resources_

> _VuFind is completely modular so you can implement just the basic system, or all of the components. And since it's open source, you can modify the modules to best fit your need or you can add new modules to extend your resource offerings._


## What is this image intended for?

This image goes to all the vufind developers that want a testing environment for their development environment set up in no time.

It is out of the box usable on linux hosts with a docker version >= 1.3

The image makes use of [smoebody/dev-dotdeb][3] - which prepares apache2, php and mysql - and wraps around your local clone of vufind2 from [https://github.com/vufind-org/vufind][2]

Please refer to [smoebody/dev-dotdeb][3] on how to use the tools provided.

## How to use this image

First you should clone the vufind2 code somewhere in your development environment (eg. /home/me/vufind2)

    git clone https://github.com/vufind-org/vufind.git /home/me/vufind2

now you can run the docker image to use this folder as vufind base and wrap the runtime environment around

    docker run --name vufind2-container -d -v /home/me/vufind2:/usr/local/vufind2 -p 127.0.0.1:80:80 -p 127.0.0.1:443:443 -p 127.0.0.1:8080:8080 -p 127.0.0.1:3306:3306 useltmann/vufind2

this starts the container named _vufind2-container_ and sets up all the components as well as vufind2 itself with its default values. you should now be able to reach the vufind2 frontend at

http://127.0.0.1/vufind/

### local or remote Solr

if you are going to use a remote solr server to serve your search requests, then you do not need the container's solr to run. in that case you can provide an environment variable to order docker not to start solr

    -e "VUFIND_SOLR=remote"

### custom httpd-vufind.conf

if you have a different apache2-setup, then you can provide a path to your httpd-vufind.conf relative to your vufind2 basepath.

    -e "VUFIND_HTTPD_CONF=local/dev/httpd-vufind.conf"

_be aware that the path has to be accessable from within the container and the specified file must exist, otherwise starting the container will fail_


for further information see the github-page at [https://github.com/finc/docker-vufind2][4]


  [1]: https://vufind-org.github.io/vufind/
  [2]: https://github.com/vufind-org/vufind/
  [3]: https://registry.hub.docker.com/u/smoebody/dev-dotdeb/
  [4]: https://github.com/finc/docker-vufind2/