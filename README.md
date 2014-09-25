# Angry Caching Proxy Docker

For more about Angry Caching Proxy, have a look at the upstream project at https://github.com/epeli/angry-caching-proxy

Huge props to Epeli for making a super useful bit of software :-)

## Docker

This fork is mostly tweaking to the Angry Caching Proxy to allow it to be used like a really aggressive version of jpetazzo's [squid-in-a-can](https://github.com/jpetazzo/squid-in-a-can) Docker container.

By really aggressive, I mean it caches GET requests and HEAD requests to anywhere (except localhost...), and caches irrespective of the status code returned.

To use the container for caching Docker container traffic, it can be run as follows:

    docker run --net host -d bgibson/angry-caching-proxy
    iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to 8080

It only really supports http requests at this point (no https) - so the iptables rule forwards traffic on port 80 to the Angry Caching Proxy container.

It's also possible to add caching for http connections for the Docker daemon (eg ADDs in a Dockerfile) by setting the http_proxy environment variable before starting it (eg `http_proxy=http://localhost:8080 docker -d`), although this seems to break https connections (including `docker pull`-ing) because docker appears to use the http_proxy variable for https connections as well (and Angry Caching Proxy doesn't support ssl).
