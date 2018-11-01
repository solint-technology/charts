#!/bin/sh

AdminPasswordsForServer_CheckEnv()
{
    BASENAME="startKSPServer.sh"
    if [ -z "$KPADMINFILE" ]; then
        echo ""
        echo "$BASENAME: WARNING: As you did not provide KPADMINFILE environment variable you will have to provide passwords in the console"
        echo ""
    else
        if [ ! -f "$KPADMINFILE" ]; then
            echo ""
            echo "$BASENAME: ERROR: Please set KPADMINFILE environment variable to point to admin password file"
            echo "                  Cannot access file $KPADMINFILE"
            echo ""
            exit 1
	    fi
    fi
}

cd `dirname "$0"`

# KSP home path
KSP_HOME_DIR=/opt/finastra/kplus-front
export KSP_HOME_DIR

# K+ home path
KPLUSHOME3=/opt/finastra/kplus-front
export KPLUSHOME3

# Groovy pricing 
GROOVY_CLASS_PATH=/opt/finastra/kplus-front/ksp/GroovyDependencies/
export GROOVY_CLASS_PATH
GROOVY_JVM_XMS=-Xms1024M
export GROOVY_JVM_XMS
GROOVY_JVM_XMX=-Xmx1024M
export GROOVY_JVM_XMX

# KGR Home path
KREDITNETHOME=/opt/finastra/fusion-risk/cmr
export KREDITNETHOME

# KGR Config PATH
KREDITNET_CONFIG_PATH=/opt/finastra/fusion-risk/cmr/config
export KREDITNET_CONFIG_PATH

# KGR Config File
KREDITNET_CONFIG_FILE=source.cfm
export KREDITNET_CONFIG_FILE

# KGR Other
KLES_PACKAGE=${KLES_PACKAGE:-"P1"}
KGR_PREFIX="$KREDITNETHOME/kles/$KLES_PACKAGE/lib/${ARCH}"

KGR_ACCESSIBLE=1
[ ! -d "$KREDITNETHOME" ] && KGR_ACCESSIBLE=0
[ ! -d "$KREDITNET_CONFIG_PATH" ] && KGR_ACCESSIBLE=0
[ ! -d "$KGR_PREFIX" ] && KGR_ACCESSIBLE=0
[ ! -f "$KREDITNET_CONFIG_PATH/$KREDITNET_CONFIG_FILE" ] && KGR_ACCESSIBLE=0

if [ $KGR_ACCESSIBLE -ne 1 ]
then
    unset KREDITNETHOME
    unset KREDITNET_CONFIG_FILE
    unset KREDITNET_CONFIG_PATH
fi

LANG=C
export LANG

# Library path (for KGR)
if [ $KGR_ACCESSIBLE -ne 0 ]
then
   LD_LIBRARY_PATH=${KGR_PREFIX}:${LD_LIBRARY_PATH} #For libKGLServices.so
fi

# Library path
unset LD_LIBRARY_PATH_64
LD_LIBRARY_PATH=${KPLUSHOME3}/lib/ext/${ARCH}:${LD_LIBRARY_PATH}
LD_LIBRARY_PATH=${KPLUSHOME3}/lib64/ext/${ARCH}:${LD_LIBRARY_PATH}
LD_LIBRARY_PATH=${KPLUSHOME3}/lib/int/${ARCH}:${LD_LIBRARY_PATH}
LD_LIBRARY_PATH=${KPLUSHOME3}/lib64/int/${ARCH}:${LD_LIBRARY_PATH}
MACHINE=`uname -s`
case "$MACHINE" in
    "SunOS")
        LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/sfw/lib/
        ;;
    "Linux")
        ;;
    *)
        echo "[ERROR] Unsupported operating system: $MACHINE"
        exit -1
esac
export LD_LIBRARY_PATH

# Contains DB config among others
KSP_CONFIG_DIR=/opt/finastra/kplus-front/entities/Standalone/config/ksp

# Set RV Config for KSP RVWrapper 
KSP_WRAPPER_SERVICE=6659
export KSP_WRAPPER_SERVICE

KSP_WRAPPER_NETWORK="eth0;;"
export KSP_WRAPPER_NETWORK

KSP_WRAPPER_DAEMON="tcp:kplus-front-rvd:7500"
export KSP_WRAPPER_DAEMON

# Unset KGR 
unset KGR_PREFIX
unset KLES_PACKAGE 

# Checks arround KPADMINFILE
AdminPasswordsForServer_CheckEnv

# Execute optional config.opt
if [ -f ./config.opt ]
then
    . ./config.opt
fi

# Set Log dir
KSP_LOG_DIR=/opt/finastra/kplus-front/entities/Standalone/log/ksp
mkdir -p "${KSP_LOG_DIR}"

# Manage optional KPADMINFILE. If not present, passwords will be prompted
if [ -z "$KPADMINFILE" ]
then
    "${KSP_HOME_DIR}/servers/${ARCH}/KSPServer" --configDir "${KSP_CONFIG_DIR}" -pid-file KSPServer.pid  $*                  2>&1 | tee -a "${KSP_LOG_DIR}/KSPServer.log"
else
    "${KSP_HOME_DIR}/servers/${ARCH}/KSPServer" --configDir "${KSP_CONFIG_DIR}" -pid-file KSPServer.pid  $* < "$KPADMINFILE" 2>&1 | tee -a "${KSP_LOG_DIR}/KSPServer.log"
fi

