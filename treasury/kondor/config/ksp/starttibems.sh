#!/bin/sh


TIBEMS_PATH=${TIBEMS_PATH:-/opt/tibco/ems/current}

cd ${TIBEMS_PATH}/bin

mkdir -p /opt/finastra/kplus-front/entities/Standalone/config/ksp/jms/datastore > /dev/null 2>&1
mkdir -p /opt/finastra/kplus-front/entities/Standalone/log/ksp/ems > /dev/null 2>&1

${TIBEMS_PATH}/bin/tibemsd -config /opt/finastra/kplus-front/entities/Standalone/config/ksp/jms/tibemsd.conf
