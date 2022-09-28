# inception
This project consists in setting up a small infrastructure composed of different
services under specific rules, hosting a wordpress blog.

## Description
* Each Docker image must have the same name as its corresponding service.
* Each service has to run in a dedicated container.
* For performance matters, the containers are built from the penultimate stable
version of Alpine Linux.
* There must be Dockerfiles, one per service. The Dockerfiles must be called in the docker-compose.yml by the Makefile.
<br />
Here is an example diagram of the expected result:
<p align="center">
  <img src="/screenshots/screen_1.png" width="50%" />
</p>

## Screenshots
<p align="center">
  <img src="/screenshots/postlist.png" width="50%" />
</p>
<p align="center">
  <img src="/screenshots/chashu.png" width="50%" />
</p>
<p align="center">
  <img src="/screenshots/ramen.png" width="50%" />
</p>
<p align="center">
  <img src="/screenshots/tagliatelles.png" width="50%" />
</p>
