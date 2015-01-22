# docker-vufind2

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

This image goes to all the vufind developers that want a runtime environment for their development environment set up in no time.

It is out of the box usable on linux hosts with a docker version >= 1.3

The image prepares apache2, php and mysql and wraps around your local clone of vufind2 from [https://github.com/vufind-org/vufind][2]

* baseimage: debian:latest (wheezy)
* apache 2.4 with libapache_mod-fcgid
* php 5.4.36 from the famous dotdeb repository
* mysql 5.6 from the famous dotdeb repository
* openjdk7-jdk

## How to use this image

first decide whether and where you want to reach the 
* vufind2 frontend (eg. http://127.0.0.1:80)
* solr frontend (eg. http://127.0.0.1:8080)
* mysql-server (eg. http://127.0.0.1:3306)

then you should clone the vufind2 code somewhere in your development environment (eg. /home/me/vufind2)

    git clone https://github.com/vufind-org/vufind.git /home/me/vufind2

now you can use the docker to use this folder as vufind base and wrap the runtime environment around

    docker run --name vufind2-container -d -v /home/me/vufind2:/usr/local/vufind2 -p 127.0.0.1:80:80 -p 127.0.0.1:8080:8080 -p 127.0.0.1:3306:3306 useltmann/vufind2

this starts the container named _vufind2-container_ and sets up all the components as well as vufind2 itself with its default values. you should now be able to reach the vufind2 frontend at

http://127.0.0.1/vufind

next step is to set up vufind2 via the frontend found here

http://127.0.0.1/vufind/Install

_please be aware that the errors on the webpage occur because the database for vufind2 is not set up yet. just follow the instructions on the page._

By default php is configured up to start a debugging session indicated by request parameters. this comes in handy to use with several browser-addons (e.g. [xdebug-helper for chrome][3]). Therefore the IDE should be configured to accept remotely started debugging sessions.

Also xdebug is able to profile script runs. the trace protocols can be used to determine potential performance issues. A tool to analyse that protocols is [webgrind][4] which is integrated in the docker image and reachable here

http://127.0.0.1/webgrind

## run the install script interactively

    docker run --rm -ti --volumes-from vufind2-container install

## run a interactive console in the container

tbd.

## inspect the logfiles

Once the container is up and running there are several methods to interoperate with it.

to run vufind2's install.php interactively you can make use of docker's container linking capabilities by using the container as following
tbd.

## import records into solr

tbd.

## reset vufind data

tbd.

  [1]: http://vufind.org/
  [2]: https://github.com/vufind-org/vufind
  [3]: https://github.com/mac-cain13/xdebug-helper-for-chrome
  [4]: https://code.google.com/p/webgrind/