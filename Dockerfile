FROM centos:latest
MAINTAINER Brendon Standing <standingb@yahoo.com>

ENV CENTOS_FRONTEND noninteractive

RUN yum update -y
RUN yum install -y wget
RUN yum install -y mysql
RUN wget -q https://downloads.powerdns.com/releases/rpm/pdns-static-3.4.10-1.x86_64.rpm && rpm -ivh pdns-static-3.4.10-1.x86_64.rpm
RUN wget -q https://downloads.powerdns.com/releases/rpm/pdns-recursor-3.7.3-1.x86_64.rpm && rpm -ivh pdns-recursor-3.7.3-1.x86_64.rpm

COPY pdns/pdns-master.conf /etc/powerdns/
COPY pdns/pdns-slave.conf /etc/powerdns/
#RUN mkdir /etc/powerdns/pdns.d
#COPY pdns/pdns.d/pdns.local.gmysql.conf /etc/powerdns/pdns.d/

EXPOSE 53/tcp
EXPOSE 53/udp
EXPOSE 80

ADD pdns.sql .
ADD start.sh .
RUN chmod +x start.sh

CMD ["./start.sh"]
