# docker-distroless

Experiments with minimalistic/distroless Docker images

## Build and run image

~~~
$ make clean
$ make all
~~~

## Inspect built image

~~~
$ docker save -o minimal.tar minimal:latest
~~~
