#!/bin/bash

# Criar volume
docker volume create nginx_logs

# Iniciar container com volume montado
docker run --name meu_nginx -d -p 8080:80 -v nginx_logs:/var/log/nginx nginx

# Gerar acessos para criar logs
for i in {1..10}; do curl -s http://localhost:8080 > /dev/null; done

# Gravar logs continuamente no volume com sudo
sudo docker logs -f meu_nginx >> /var/lib/docker/volumes/nginx_logs/_data/access.log &
LOG_PID=$! # Salva o PID do processo de logs

# Gerar acessos para criar logs
for i in {1..10}; do curl -s http://localhost:8080 > /dev/null; done

# Parar e remover o container
docker stop meu_nginx
docker rm meu_nginx

# Iniciar container com volume montado
docker run --name meu_nginx -d -p 8080:80 -v nginx_logs:/var/log/nginx nginx

# Gerar acessos para criar logs
for i in {1..10}; do curl -s http://localhost:8080 > /dev/null; done

# Gravar logs continuamente no volume com sudo
sudo docker logs -f meu_nginx >> /var/lib/docker/volumes/nginx_logs/_data/access.log &
LOG_PID=$! # Salva o PID do processo de logs

# Salva um log onde o script foi rodado, slavando todo o log
docker logs -f meu_nginx >> ./access.log

sudo docker exec -it meu_nginx cat /var/log/nginx/access.log



