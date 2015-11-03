FROM ubuntu:14.04

# Fix locales so that en_US.utf8 works???
RUN apt-get install -y locales && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8
#RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen
#RUN update-locale LANG="en_US.UTF-8" && \
#    update-locale LANGUAGE="en_US.UTF-8" && \
#    update-locale LC_ALL="en_US.UTF-8"

# Important stuff!
COPY ACCC4CF8.asc /tmp/ACCC4CF8.asc
RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main' >>/etc/apt/sources.list.d/pgdg.list && \
	apt-key add /tmp/ACCC4CF8.asc && \
	apt-get update -y
RUN apt-get install -y \
	postgresql-9.4 \
	postgresql-client-9.4 \
	postgresql-contrib-9.4 \
	postgresql-9.4-postgis-2.1

RUN apt-get install -y \
	apache2 \
	php5 \
	php5-cli \
	php5-pgsql \
	libapache2-mod-php5

# Jarva!
RUN apt-get install -y openjdk-7-jdk

# Build tools
RUN apt-get install -y \
	git \
	wget \
	make

#COPY nodesource.gpg.key /tmp/nodesource.gpg.key
#RUN add-apt-repository -y -r ppa:chris-lea/node.js && \
#	echo 'deb https://deb.nodesource.com/node_0.12 trusty-pgdg main' >>/etc/apt/sources.list.d/nodesource.list && \
#	apt-key add /tmp/nodesource.gpg.key && \
#	apt-get update -y && \
#	apt-get install -y nodejs
# Blah whatever
RUN wget -qO- https://deb.nodesource.com/setup_4.x | sudo bash - && \
	apt-get install -y nodejs

# Install handy utilities for interactive use
RUN apt-get install -y tig emacs24-nox screen php-elisp

# Install composer
RUN wget https://getcomposer.org/installer -O - | php && mv composer.phar /usr/local/bin/composer

# Enable some apache modules
RUN a2enmod rewrite

RUN mkdir /home/ppdo && useradd -s /bin/bash -d /home/ppdo ppdo && chown ppdo:ppdo /home/ppdo

# Check out the deployment manager scripts
RUN mkdir /root/PhrebarDeploymentManager && \
    cd /root/PhrebarDeploymentManager && \
    git init && \
    git remote add github 'https://github.com/EarthlingInteractive/PhrebarDeploymentManager.git' && \
    git fetch --all && \
    git reset --hard bd14f268ab28b6beb3943f27a89bceb766e607f7 && \
    sed -e 's#deployments#/home/ppdo/deployments#' config.json.example >config.json

# Add some dotfiles
COPY home/ /root/

EXPOSE 80

ENTRYPOINT \
	/etc/init.d/apache2 start && \
	/etc/init.d/postgresql start && \
	exec /root/PhrebarDeploymentManager/deployment-server
