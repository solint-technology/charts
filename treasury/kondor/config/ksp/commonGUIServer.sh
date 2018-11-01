#!/bin/ksh

export HOSTNAME=$(uname -n)
export JAVA_HOME=/usr/java/latest/jre
export CATALINA_HOME=/opt/finastra/kplus-front/3rdparties/tomcat
export CATALINA_BASE=/opt/finastra/kplus-front/entities/Standalone/config/ksp/appliserver
export APPLICATION_CONF=/opt/finastra/kplus-front/entities/Standalone/config/ksp/webconf
export CATALINA_TMPDIR=$CATALINA_BASE/tmp
export CATALINA_PID=$CATALINA_BASE/guiServer.pid
export CATALINA_OUT=/opt/finastra/kplus-front/entities/Standalone/log/ksp//catalina.out

export JAVA_MEMORY_OPTS="-Xms256m -Xmx1024m -d64 -XX:MaxPermSize=256m"
