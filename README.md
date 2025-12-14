
# sample-docker

Experiments with minimalistic/distroless Docker images

## Build images

~~~
$ make clean
$ make all
~~~

## Inspect built image

~~~
$ docker save -o minimal.tar philip/minimal:latest
~~~
