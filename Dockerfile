FROM openjdk:8-alpine
MAINTAINER shiva
ARG CONT_IMG_VER
WORKDIR /usr/local/tomcat/webapps
EXPOSE 8080
COPY  ./gameoflife-web/target/gameoflife.war /usr/local/tomcat/webapps/gameoflige.war
