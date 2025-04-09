#!/bin/bash
docker pull nginx
docker run -d --name meu-servidor -p 8091:80 nginx
docker container ls
docker container stop meu-servidor
docker container rm meu-servidor
docker container ls -a