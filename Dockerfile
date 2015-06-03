FROM iojs:onbuild
MAINTAINER Bryce Gibson "bryce.gibson@unico.com.au"

VOLUME /cache

ENTRYPOINT [ "./bin/angry-caching-proxy" , "--directory", "/cache" ]
