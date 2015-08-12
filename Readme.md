# docker-vufind2

These are the sources of [useltmann/vufind2][1], the docker-image for a easy-to-use DTE. it utilizes [smoebody/dev-dotdeb][2] as base image for lamp DTEs.

feel free to use for your own, i would appreciate contributions as pullrequests.
 
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

for better control over docker containers most people - including me - use [docker-compose][3] as docker container description in their source folders. i recommend you to do so as well by creating a file called `docker-compose.yml` with the following content

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

  [1]: https://registry.hub.docker.com/u/useltmann/vufind2/
  [2]: https://registry.hub.docker.com/u/smoebody/dev-dotdeb/
  [3]: https://www.docker.com/docker-compose
