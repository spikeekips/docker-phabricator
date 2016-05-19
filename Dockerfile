FROM nasqueron/nginx-php-fpm
MAINTAINER Sébastien Santoro aka Dereckson <dereckson+nasqueron-docker@espace-win.org>

RUN apt-get update && \
    apt-get install -y \
        mercurial subversion python-pygments openssh-client locales \
        mysql-client imagemagick nodejs node-ws \
        --no-install-recommends && \
    rm -r /var/lib/apt/lists/*

RUN echo en_US.UTF-8 UTF-8 > /etc/locale.gen && locale-gen
	
RUN cd /opt && \
    git clone https://github.com/phacility/libphutil.git && \
    git clone https://github.com/phacility/arcanist.git && \
    git clone https://github.com/phacility/phabricator.git && \
    mkdir -p /var/tmp/phd && \
    chown app:app /var/tmp/phd

COPY files /

VOLUME ["/opt/phabricator/conf/local", "/var/repo"]

WORKDIR /opt/phabricator
CMD ["/usr/local/sbin/init-container"]
