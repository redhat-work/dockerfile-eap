FROM centos:7

MAINTAINER Vitor Silva Lima <vitor.lima2@fatec.sp.gov.br>

# Set the WILDFLY_VERSION env variable
ENV JBOSS_HOME /opt/eap
ENV JAVA_HOME /opt/java
ENV MNGT_USER admin
ENV MNGT_PWD  admin
#add binaries for eap and java
RUN mkdir -p /opt/eap /opt/java
COPY jboss-eap-7.0/ $JBOSS_HOME
COPY jdk1.8.0_71/ /opt/java

#copy the configuration files for both domain controller and host controller
ADD domain/configuration/* $JBOSS_HOME/domain/configuration/

#the scrip that is called on the startup
ADD entrypoint.sh $JBOSS_HOME/bin

#ports that are exposed
EXPOSE 8080 9990 9999

ENTRYPOINT ["/opt/eap/bin/entrypoint.sh"]
CMD ["-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]