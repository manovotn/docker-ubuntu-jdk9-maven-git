FROM ubuntu:16.10

MAINTAINER manovotn

RUN apt-get update; apt-get install -y \
    software-properties-common \
    python-software-properties \
    wget -y

#get Java, we need to do so manually, as repositories are:
# - steaming pile of poop
# - outdated
# - broken (security exception)
RUN wget http://www.java.net/download/java/jigsaw/archive/142/binaries/jigsaw-jdk-9-ea+142_linux-x64_bin.tar.gz -O jdk-9.tar.gz
RUN tar -zxvf jdk-9.tar.gz

# prepare env variables for Java
ENV JAVA_HOME /jdk-9
ENV PATH $PATH:$JAVA_HOME/bin

#update because who knows why :)
RUN apt-get update -y

#get Maven 3.3.9
RUN wget http://apache.mirror.anlx.net/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
RUN tar -zxf apache-maven-3.3.9-bin.tar.gz
RUN cp -R apache-maven-3.3.9 /usr/local
RUN ln -s /usr/local/apache-maven-3.3.9/bin/mvn /usr/bin/mvn
RUN ln -s /usr/local/apache-maven-3.3.9/bin/mvnDebug /usr/bin/mvnDebug

#get some Git
RUN apt-get install git -y

#clone repo with simple JDK 9 project
RUN git clone https://github.com/manovotn/JDK9Playground.git

#trigger build
RUN mvn clean install -f JDK9Playground/pom.xml

# if you run this image in -it mode, then you get into badh
CMD "/bin/bash"
