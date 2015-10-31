FROM ubuntu:14.04

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
	libapache2-mod-php5

EXPOSE 80

# More important stuff!
RUN apt-get install -y emacs24-nox screen php-elisp

COPY start-da-servers.sh /etc/start-da-servers
COPY run-da-servers.sh /etc/run-da-servers
COPY run-da-servers-interactive.sh /etc/run-da-servers-interactive
RUN chmod +0755 /etc/start-da-servers /etc/run-da-servers /etc/run-da-servers-interactive

CMD /etc/run-da-servers