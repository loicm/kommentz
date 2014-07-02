FROM ubuntu:14.04
MAINTAINER Loïc Mathaud <loic@mathaud.fr>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

# Install supervisord
RUN apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor
ADD docker/supervisor.conf /etc/supervisor/conf.d/supervisor.conf

# Install redis
RUN apt-get -y install redis-server

# Install nginx
RUN apt-get -y install nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD docker/nginx/default /etc/nginx/sites-available/default

# Install php-fpm
RUN apt-get -y install php5-fpm php5-cli php5-redis
RUN echo "cgi.fix_pathinfo = 0;" >> /etc/php5/fpm/php.ini
RUN echo "date.timezone = Europe/Paris;" >> etc/php5/fpm/php.ini

ADD . /var/www/kommentz/
RUN chown -R www-data:www-data /var/www

EXPOSE 80

ENTRYPOINT ["/usr/bin/supervisord"]