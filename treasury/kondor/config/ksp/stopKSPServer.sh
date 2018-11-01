#!/bin/sh

# Init command
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
    echo "[ERROR] The mandatory command '$PS' is missing in your env => Cannot stop the KSPServer!"
    exit 1
fi

# Find all KSPServer pid
PID=`$PS $PSARGS | $GREP "/opt/finastra/kplus-front/servers/${ARCH}/KSPServer --configDir /opt/finastra/kplus-front/entities/Standalone/config/ksp" | $GREP -v grep | $SED 's/  */ /g' | $SED 's/^ //' | $CUT -d ' ' -f 2`
if [ $? -ne 0 ]; then
    echo "[ERROR] Failed to retrieve the KSPServer pid!"
    exit 1
fi

# Kill all KSPServer pid
if [ -z "$PID" ]; then
    echo "[WARNING] The KSP Server is not running!"
else
    kill -9 $PID > /dev/null 2>&1
    if [ "$?" -ne 0 ]; then
        echo "[ERROR] Failed to kill the KSPServer!"
        exit 1
    fi
    echo "[INFO] The KSPServer has been stopped."
    exit 0
fi
