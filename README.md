Docker image
====

The relevant Docker Hub repository is - [manovotn/ubuntu-jdk9-maven-git](https://hub.docker.com/r/manovotn/ubuntu-jdk9-maven-git/).

This image is built on top of Ubuntu 16 and adds opendjk 9, Maven 3.3.9 and Git.
Furthermore it checkouts simple JDK 9 project and builds it.

When run in `-it` mode, you will end up in bash.
