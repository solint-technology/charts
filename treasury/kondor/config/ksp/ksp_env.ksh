#!/bin/ksh
# This script is called by kloader to set whatever variables needed by KSP binaries

# KSP Root Installation folder (containing binaries...)
KSP_HOME_DIR=/opt/finastra/kplus-front

# K+ Root Installation folder (containing bin,entities...)
KPLUSHOME3=/opt/finastra/kplus-front

# KGR Home path
KREDITNETHOME=/opt/finastra/fusion-risk/cmr

# KGR Config PATH
KREDITNET_CONFIG_PATH=/opt/finastra/fusion-risk/cmr/config

# KGR Config File
KREDITNET_CONFIG_FILE=source.cfm

# KSP Config Dir
KSP_CONFIG_DIR=/opt/finastra/kplus-front/entities/Standalone/config/ksp

# JMS/EMS install path
TIBEMS_DIR=/opt/tibco/ems/current

# Path for KSP logs
KSP_LOG_DIR=/opt/finastra/kplus-front/entities/Standalone/log/ksp

KGR_ACCESSIBLE=0

if [ TRUE = TRUE ]; then

    # KGR variables settings
    KLES_PACKAGE=${KLES_PACKAGE:-"P1"}
    KGR_PREFIX="$KREDITNETHOME/kles/$KLES_PACKAGE/lib/${ARCH}"
    KGR_ACCESSIBLE=1
    [ ! -d "$KREDITNETHOME" ] && KGR_ACCESSIBLE=0
    [ ! -d "$KREDITNET_CONFIG_PATH" ] && KGR_ACCESSIBLE=0
    [ ! -d "$KGR_PREFIX" ] && KGR_ACCESSIBLE=0
    [ ! -f "$KREDITNET_CONFIG_PATH/$KREDITNET_CONFIG_FILE" ] && KGR_ACCESSIBLE=0

    if [ $KGR_ACCESSIBLE -ne 1 ]
    then
        echo "KGR Environment is not set"
        unset KREDITNETHOME
        unset KREDITNET_CONFIG_FILE
        unset KREDITNET_CONFIG_PATH
    fi
else
    unset KREDITNETHOME
    unset KREDITNET_CONFIG_FILE
    unset KREDITNET_CONFIG_PATH
fi

#The library path
MACHINE=`uname -s`
case "$MACHINE" in
    "SunOS")
        if [ $KGR_ACCESSIBLE -ne 0 ]
        then
            LD_LIBRARY_PATH=${KGR_PREFIX}:${LD_LIBRARY_PATH}
        fi
        LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/sfw/lib/
        export LD_LIBRARY_PATH
    ;;
    "Linux")
        if [ $KGR_ACCESSIBLE -ne 0 ]
        then
            LD_LIBRARY_PATH=${KGR_PREFIX}:${LD_LIBRARY_PATH}
        fi
        export LD_LIBRARY_PATH
    ;;
    *)
        echo "[ERROR] Unsupported operating system: $MACHINE"
        exit -1
esac
