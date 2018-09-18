FROM ubuntu
EXPOSE 80
EXPOSE 53
WORKDIR /
COPY bind-check.sh .
RUN apt-get update && apt-get upgrade -y
RUN apt-get install apt-transport-https gnupg2 wget bind9 -y 

RUN echo "deb https://download.webmin.com/download/repository sarge contrib" >> /etc/apt/sources.list && \
cd /root && \
wget http://www.webmin.com/jcameron-key.asc && \
apt-key add jcameron-key.asc 

RUN rm /etc/apt/apt.conf.d/docker-gzip-indexes && \
apt-get purge apt-show-versions -y && \
rm /var/lib/apt/lists/*lz4 && \
apt-get -o Acquire::GzipIndexes=false update -y

RUN apt-get update && apt-get install webmin -y

RUN sed -i 's/10000/80/g' /etc/webmin/miniserv.conf && \
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf 

RUN echo root:webmin | chpasswd
CMD [ "/bin/bash","/bind-check.sh" ]