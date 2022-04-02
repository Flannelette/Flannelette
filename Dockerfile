FROM tomcat:latest

LABEL maintainer="Flannelette"

RUN apt-get update

RUN apt-get upgrade -y

ADD ./target/LoginWebApp-1.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]
