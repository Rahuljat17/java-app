FROM tomcat:8.0.20-jre8

MAINTAINER choudharyji

COPY target/java-web-app*.war /usr/local/tomcat/webapps/java-web-app.war
