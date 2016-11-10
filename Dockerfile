FROM ubuntu:16.10

RUN apt-get update; apt-get install -y \
    software-properties-common \
    python-software-properties

#first, get openjdk-9
RUN apt install openjdk-9-jdk -y

#RUN echo oracle-java9-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections

#RUN add-apt-repository -y ppa:webupd8team/java && \
#   apt-get update; \
#   apt-get install -y oracle-java9-installer; \
#   apt-get install -y oracle-java9-set-default; \
#rm -rf /var/cache/oracle-jdk9-installer

#update or die :-P
RUN sudo apt-get -qq update

#get Maven 3.3.9
RUN wget http://apache.mirror.anlx.net/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
RUN tar -zxf apache-maven-3.3.9-bin.tar.gz
RUN sudo cp -R apache-maven-3.3.9 /usr/local
RUN sudo ln -s /usr/local/apache-maven-3.3.9/bin/mvn /usr/bin/mvn
RUN sudo ln -s /usr/local/apache-maven-3.3.9/bin/mvnDebug /usr/bin/mvnDebug

#get some Git
RUN sudo apt-get install git -y

#clone repo with simple JDK 9 project
#RUN git clone https://github.com/manovotn/JDK9Playground.git

#trigger build
RUN mvn clean install -f JDK9Playground/pom.xml

# if you run this image in -it mode, then you get into badh
CMD "/bin/bash"
