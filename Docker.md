# vufind2

## What is Vufind?

from [http://vufind.org/][1]

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

    docker run --name vufind2-container -d -v /home/me/vufind2:/app -p 127.0.0.1:80:80 -p 127.0.0.1:443:443 -p 127.0.0.1:8080:8080 -p 127.0.0.1:3306:3306 useltmann/vufind2

this starts the container named _vufind2-container_ and sets up all the components as well as vufind2 itself with its default values. you should now be able to reach the vufind2 frontend at

http://127.0.0.1/vufind/

### local or remote Solr

if you are going to use a remote solr server to serve your search requests, then you do not need the container's solr to run. in that case you can provide an environment variable to order docker not to start solr

    -e "VUFIND_SOLR=remote"

### custom httpd-vufind.conf

if you have a different apache2-setup, then you can provide a path to your httpd-vufind.conf relative to your vufind2 basepath.

    -e "VUFIND_HTTPD_CONF=local/dev/httpd-vufind.conf"

_be aware that the path has to be accessable from within the container and the specified file must exist, otherwise starting the container will fail_

## Setup VuFind2

next step is to set up vufind2 via the frontend found here

http://127.0.0.1/vufind/Install

_please be aware that the errors on the webpage occur because the database for vufind2 is not set up yet. just follow the instructions on the page._

The container's MySQL Server is set up with user *root* and no password. when you are prompted to fill in root's password yust leave it empty.

## run phpunit on sourcecode

with a running vufind2-container you can either use the interactive console to run phpunit or you can make use of a single docker command script to run phpunit in a dedicated container

    docker run --rm -ti -v /home/me/vufind2:/app useltmann/vufind2 phpunit

_a new container is initialized and a script is invoked which runs the default phpunit command to test the vufind2 code as the vufind-org ci-server would do. 
the container is removed immediately after phpunit has finished._

## run codesniffer on sourcecode

the same applies to codesniffer as it does for phpunit. the command to run though is

    docker run --rm -ti -v /home/me/vufind2:/app useltmann/vufind2 phpcs
    

## run an interactive console in the container

for interaction with vufind within the container you have to start a bash from within the container. do so by doing

    docker exec -ti vufind2-container bash

you are now "logged in" the vufind2-container as user *root*. in order to work with vufind you should switch to user *dev*

    su -l dev

_this assures that all files you create remain accessable, editable and removable by you from outside the container_

## import records into solr

tbd.

## reset vufind data

to remove all project unspecific files from vufind you should do

    git clean -d -x -n

which *shows* you what will be removed in order to clean the project path from either ignored or unversioned files and folders.

To *perform* the cleanup you have to omit the *-n* flag.

after that your docker container is not able to run anymore since you deleted the configuration it needs (at least apache2). yust remove the container by running

    docker rm vufind2-container

and run a new one by invoking the command as listed on top

## docker-compose

for better control over docker containers most people - including me - use [docker-compose][4] as docker container description in their source folders. i recommend you to do so as well by creating a file called `docker-compose.yml` with the following content

```
lamp:
  image: useltmann/vufind2
  ports:
    - "80:80"
    - "443:443"
    - "8080:8080"
    - "3306:3306"
  volumes:
    - "./:/app"
```

after that you can run the following command from within the vufind2 source folder

    docker-compose up

_(re)creates the container based on the existing image. if no local image is found, the docker-registry is asked for it and pulled on existence._

    docker-compose stop
    
_stops the container_

    docker-compose start
    
_starts the already existing container. to the contrary of `docker-compose up` the containers are not recreated (on first sight there is no difference to it since
the data-volumes are not recreated by `docker-compose up`. but its the data-volumes, where the database is residing. and the sourcecode comes from your mounted host-system)_

to remove the existing container (in order to recreate a new container with a fresh database) you have to remove the container first

    docker-compose rm
    
to run a single command i.e. a script like _phpunit_ or_phpcs_ you can use docker-compose as well

    docker-compose run --rm lamp phpunit
    
_the container is removed immediately after the command is finished._
 
please refer to the website for further explanation.

  [1]: http://vufind.org/
  [2]: https://github.com/vufind-org/vufind
  [3]: https://registry.hub.docker.com/u/smoebody/dev-dotdeb/
  [4]: https://www.docker.com/docker-compose