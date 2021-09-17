FROM debian:buster-slim

LABEL maintainer="support@ip2location.com"

# Install packages
RUN apt-get update && apt-get install -y mariadb-server wget unzip cron

# Add MySQL configuration
ADD custom.cnf /etc/mysql/mariadb.conf.d/999-custom.cnf

# Add scripts
ADD run.sh /run.sh
ADD update.sh /update.sh
RUN chmod 755 /*.sh

ADD crontab /var/spool/cron/crontabs/root
RUN crontab /var/spool/cron/crontabs/root

# Exposed ENV
ENV TOKEN FALSE
ENV CODE FALSE
ENV MYSQL_PASSWORD FALSE

# Add VOLUMEs
VOLUME  ["/etc/mysql", "/var/lib/mysql"]

EXPOSE 3306 33060
CMD ["bash", "-c", "/etc/init.d/cron start && /run.sh"]