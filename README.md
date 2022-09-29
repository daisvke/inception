# inception
This project consists in setting up a small infrastructure composed of different
services under specific rules, hosting a personal wordpress cooking blog.

## Description
* Each Docker image must have the same name as its corresponding service.
* Each service has to run in a dedicated container.
* For performance matters, the containers are built from the penultimate stable
version of Alpine Linux.
* There must be Dockerfiles, one per service. The Dockerfiles must be called in the docker-compose.yml by the Makefile.

Here is an example diagram of the expected result:
<br />
<p align="center">
  <img src="/screenshots/diagram.png" width="50%" />
</p>

## Commands
Run:
```
sudo make
```
Get inside a container and launch a command:
```
sudo docker exec -it [container] [command]

ex: to get into the mariadb database:
sudo docker exec -it mariadb mariadb -uroot -proot
```

## Screenshots
<p align="center">
  <img src="/screenshots/home.png" width="45%" />
  <img src="/screenshots/nigiri.png" width="45%" />
  <img src="/screenshots/chashudon.png" width="45%" />
  <img src="/screenshots/ramen.png" width="45%" />
  <img src="/screenshots/tagliatelles.png" width="45%" />
</p>
