FROM tomcat:8-jre8
MAINTAINER Varun Gupta vxg@projectvisionhealth.com
# Remove unneeded apps
RUN rm -rf /usr/local/tomcat/webapps/examples
RUN rm -rf /usr/local/tomcat/webapps/docs
RUN rm -rf /usr/local/tomcat/webapps/manager

RUN apt-get update -y
RUN apt-get install -y vim

#Copy the mainlayer webapp folder to correct location.
COPY mainlayer /usr/local/tomcat/webapps/mainlayer
COPY server.xml /usr/local/tomcat/conf/
COPY tomcat-stdout-accesslog-0.2.jar /usr/local/tomcat/lib/
COPY mainlayerOverride.properties /usr/local/tomcat/webapps/mainlayer/WEB-INF/classes/

RUN rm -f /usr/local/tomcat/webapps/mainlayer/WEB-INF/classes/log4j2.xml
COPY log4j2.xml /usr/local/tomcat/webapps/mainlayer/WEB-INF/classes/

#Copy the ROOT webapp to correct location
COPY ROOT /usr/local/tomcat/webapps/ROOT
