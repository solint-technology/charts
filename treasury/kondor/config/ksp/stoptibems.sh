#!/bin/sh

# Init command
TIBEMS_PATH=${TIBEMS_PATH:-/opt/tibco/ems/current}
GREP=/bin/grep
SED=/bin/sed
CUT=/bin/cut
PS=
PSARGS="auxwwww"
MACHINE=`uname -s`
case "$MACHINE" in
    "SunOS")
        PS="/usr/ucb/ps"
        ;;
    "Linux")
        PS="/bin/ps"
        ;;
    *)
        echo "[ERROR] Cannot guess your machine $MACHINE"
        exit 1
esac

if [ ! -x $PS ]; then
    echo "[ERROR] The mandatory command '$PS' is missing in your env => Cannot stop the tibemsd!"
    exit 1
fi

# Find all tibemsd pid
PID=`$PS $PSARGS | $GREP "${TIBEMS_PATH}/bin/tibemsd -config /opt/finastra/kplus-front/entities/Standalone/config/ksp/jms/tibemsd.conf" | $GREP -v grep | $SED 's/  */ /g' | $SED 's/^ //' | $CUT -d ' ' -f 2`
if [ $? -ne 0 ]; then
    echo "[ERROR] Failed to retrieve the tibemsd pid!"
    exit 1
fi

# Kill all tibemsd pid
if [ -z "$PID" ]; then
    echo "[WARNING] The tibemsd is not running!"
else
    kill -9 $PID > /dev/null 2>&1
    if [ "$?" -ne 0 ]; then
        echo "[ERROR] Failed to kill the tibemsd!"
        exit 1
    fi
    echo "[INFO] The tibemsd has been stopped."
    exit 0
fi
