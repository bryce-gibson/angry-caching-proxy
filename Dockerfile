FROM node:0.10
MAINTAINER Bryce Gibson "bryce.gibson@unico.com.au"

#Hosts file modification workaround -> copied from docker-baseimage
RUN apt-get update; apt-get install -y perl
RUN mkdir /etc/workaround-docker-2267 ; cp /etc/hosts /etc/workaround-docker-2267/ ; ln -s /etc/workaround-docker-2267 /cte
RUN /usr/bin/perl -pi -e 's:/etc/hosts:/cte/hosts:g' $(find / -name libnss_files.so.2)

ADD . /vagrant
WORKDIR /vagrant
RUN npm install
VOLUME /cache

CMD ./bin/angry-caching-proxy --directory /cache
